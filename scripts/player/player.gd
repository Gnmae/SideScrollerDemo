extends CharacterBody2D

@export var state_machine : Node

const SPEED = 250.0
const JUMP_VELOCITY = -400.0
const KNOCKBACK = -100.0

var direction = 1
var knockback_velocity = 0.0

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
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY

	var input_direction := Input.get_axis("left_arrow", "right_arrow")
	if input_direction:
		direction = input_direction # update facing direction
		if direction < 0:
			$Weapon.position = Vector2(-14.0, -1.0)
		else:
			$Weapon.position = Vector2(14.0, -1.0)
		velocity.x = input_direction * SPEED
	else:
		velocity.x = 0 + knockback_velocity

	move_and_slide()

func take_knockback():
	knockback_velocity = KNOCKBACK
	await get_tree().create_timer(0.1).timeout
	knockback_velocity = 0

func take_damage(amt, source):
	if $StateMachine.current_state.name.to_lower() == "parrying":
		$Sounds/ParrySuccessful.play(0.7)
		source.parried()
		return
	current_health -= amt
	StatsChanged.emit(current_health, max_health)
	take_knockback()
