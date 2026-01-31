class_name Player extends CharacterBody2D

@export var state_machine : Node

#region movement script variables
const SPEED = 400.0
const INITIAL_JUMP_VELOCITY = -700.0
const JUMP_VELOCITY = -350.0
const MAX_JUMP_HOLD_TIME = 0.2
const KNOCKBACK = -200.0

var direction = 1
var dir_y = 0
var knockback_velocity = 0.0
var can_jump : bool = false
var jumped : bool = false
var jump_hold_timer : float = 0.0

var gravity : float = 1500.0
var current_gravity : float = gravity
var fast_fall_multiplier : float = 2.5
var jumping_multiplier : float = 0.5 

#region input/controller related variables
@onready var controller_container = $ControllerContainer

var controller : PlayerController
var horizontal_input
var vertical_input
var jump_pressed : bool = false

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
		velocity.y = INITIAL_JUMP_VELOCITY
		jump_hold_timer = 0.0
		jumped = true
	elif jump_hold_timer < MAX_JUMP_HOLD_TIME:
		velocity.y += JUMP_VELOCITY * get_physics_process_delta_time()
		current_gravity = gravity * jumping_multiplier
		jump_hold_timer += get_physics_process_delta_time()
		jump_pressed = true
	jump_pressed = false

func _physics_process(delta: float) -> void:
	
	if state_machine.current_state.name.to_lower() == "dashing":
		move_and_slide()
		return
	
	if not is_on_floor():
		velocity.y += current_gravity * delta
	if jump_pressed and jump_hold_timer < MAX_JUMP_HOLD_TIME:
		current_gravity = gravity * jumping_multiplier
	elif jumped:
		current_gravity = gravity * fast_fall_multiplier
	else:
		current_gravity = gravity

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

func take_knockback():
	knockback_velocity = KNOCKBACK
	await get_tree().create_timer(0.1).timeout	
	knockback_velocity = 0

func hurt_animation():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	self.modulate = Color(6, 6, 6)
	tween.tween_property(self, "modulate", Color(1, 1, 1), 0.2)
	tween.tween_property(self, "modulate", Color(2, 2, 2), 0.1)
	tween.tween_property(self, "modulate", Color(1, 1, 1), 0.2)
	tween.tween_property(self, "modulate", Color(2, 2, 2), 0.1)
	tween.tween_property(self, "modulate", Color(1, 1, 1), 0.2)

func _on_coyote_timer_timeout() -> void:
	can_jump = false
