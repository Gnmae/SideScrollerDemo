extends CharacterBody2D

@export var state_machine : Node

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

signal StatsChanged
var max_health = 500.0
var current_health

func _ready()-> void:
	current_health = max_health
	StatsChanged.emit(current_health, max_health)

func _physics_process(delta: float) -> void:
	if state_machine.current_state.name.to_lower() == "dashing":
		move_and_slide()
		return
	
	if not is_on_floor():
		velocity.y += current_gravity * delta
	else:
		current_gravity = gravity

	if can_jump == false and is_on_floor():
		can_jump = true
	
	if (is_on_floor() == false) and can_jump and $CoyoteTimer.is_stopped():
		$CoyoteTimer.start()
	
	if can_jump:
		if Input.is_action_just_pressed("Jump"):
			velocity.y = INITIAL_JUMP_VELOCITY
			jump_hold_timer = 0.0
			jumped = true
	else:
		if Input.is_action_pressed("Jump") and jump_hold_timer < MAX_JUMP_HOLD_TIME:
			velocity.y += JUMP_VELOCITY * get_physics_process_delta_time()
			current_gravity = gravity * jumping_multiplier
			jump_hold_timer += delta
		elif jumped == true:
			current_gravity = gravity * fast_fall_multiplier
		else:
			jumped = false
	

	var input_direction := Input.get_axis("left_arrow", "right_arrow")
	var input_dir_y := Input.get_axis("down_arrow", "up_arrow")
	if input_direction:
		if state_machine.current_state.name.to_lower() != "attacking":
			direction = input_direction # update facing direction
		velocity.x = input_direction * SPEED
	else:
		velocity.x = 0 + knockback_velocity
	
	if input_dir_y:
		dir_y = input_dir_y
	else:
		dir_y = 0
	if dir_y < 0 and velocity.y == 0:
		dir_y = 0

	move_and_slide()

func jump():
	pass


func take_knockback():
	knockback_velocity = KNOCKBACK
	await get_tree().create_timer(0.1).timeout
	knockback_velocity = 0

func take_damage(amt, source):
	if $StateMachine.current_state.name.to_lower() == "parrying":
		$Sounds/ParrySuccessful.play(0.7)
		source.parried()
		frame_freeze(0.05, 0.4)
		return
	current_health -= amt
	StatsChanged.emit(current_health, max_health)
	hurt_animation()
	frame_freeze(0.05, 0.4)
	take_knockback()

func frame_freeze(timeScale, duration):
	Engine.time_scale = timeScale
	await get_tree().create_timer(duration * timeScale).timeout
	Engine.time_scale = 1

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
