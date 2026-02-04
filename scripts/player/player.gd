class_name Player extends CharacterBody2D

@export var state_machine : Node

#region movement script variables
const SPEED = 400.0
const JUMP_VELOCITY = 500.0
const KNOCKBACK = -200.0

var direction = 1
var dir_y = 0

var knockback_velocity = 0.0

var can_move : bool = true

var can_jump : bool = false
var jumped : bool = false
var air_jumps : int = 1
var current_air_jumps : int = 1
var jump_buffered : bool = false
@onready var jump_buffer_timer = $JumpBufferTimer
@onready var jump_height_timer = $JumpHeightTimer

var gravity : float = 1500.0
var current_gravity : float = gravity
var fast_fall_multiplier : float = 1.15

#region input/controller related variables
@onready var controller_container = $ControllerContainer

var controller : PlayerController
var horizontal_input
var vertical_input

#region functions

func _ready() -> void:
	set_controller(PlayerController.new(self))

func set_controller(_controller : PlayerController) -> void:
	# Delete all previous controllers
	for child in controller_container.get_children():
		child.queue_free()
	
	controller = _controller
	controller_container.add_child(controller)

func move(input : Vector2) -> void:
	horizontal_input = input.x
	vertical_input = input.y

func jump():
	if can_jump:
		jump_height_timer.start()
		velocity.y = -JUMP_VELOCITY
		jumped = true
		can_jump = false
	elif jumped:
		if current_air_jumps > 0:
			velocity.y = -JUMP_VELOCITY
			current_air_jumps -= 1
	elif !jump_buffered:
		jump_buffered = true
		jump_buffer_timer.start()

func _physics_process(delta: float) -> void:
	if !can_move:
		velocity = Vector2.ZERO
		return
	
	if state_machine.current_state.name.to_lower() == "dashing":
		move_and_slide()
		return
	
	if not is_on_floor():
		velocity.y += current_gravity * delta
	if not is_on_floor() and velocity.y >= 0 and jumped:
		velocity.y += current_gravity * delta * fast_fall_multiplier
	

	if can_jump == false and is_on_floor():
		can_jump = true
	
	if (is_on_floor() == false) and can_jump and $CoyoteTimer.is_stopped():
		$CoyoteTimer.start()

	if horizontal_input:
		if state_machine.current_state.name.to_lower() != "attacking":
			direction = horizontal_input # update facing direction
		velocity.x = horizontal_input * SPEED
	else:
		velocity.x = 0 + knockback_velocity
	
	if vertical_input:
		dir_y = vertical_input
	else:
		dir_y = 0
	if dir_y < 0 and velocity.y == 0:
		dir_y = 0

	move_and_slide()

	# touched ground
	if is_on_floor():
		current_air_jumps = air_jumps
		jumped = false
		if jump_buffered:
			jump_buffered = false
			can_jump = true
			jump()

func take_knockback():
	knockback_velocity = KNOCKBACK
	await get_tree().create_timer(0.1).timeout	
	knockback_velocity = 0

func _on_coyote_timer_timeout() -> void:
	can_jump = false

func _on_jump_height_timer_timeout() -> void:
	if !Input.is_action_pressed("Jump"):
		if velocity.y < -100:
			velocity.y = -100

func _on_jump_buffer_timer_timeout() -> void:
	jump_buffered = false
