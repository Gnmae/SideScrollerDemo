extends Node

@export var animation_tree: AnimationTree
@export var player : CharacterBody2D

var dir_locked : bool = false

@warning_ignore("unused_parameter")
func _ready() -> void:
	# connect signals for anim changes
	%StateMachine.StateChanged.connect(on_state_changed)
	player.PlayerJumped.connect(on_player_jumped)
	player.PlayerFalling.connect(on_player_falling)
	player.PlayerGrounded.connect(on_player_grounded)
	
	# set base anims for no input
	var y_dir = player.velocity.normalized().y
	if y_dir > 0:
		animation_tree.set("parameters/Transition/transition_request", "Falling")
	elif y_dir < 0:
		animation_tree.set("parameters/Transition/transition_request", "Jumping")
	else:
		animation_tree.set("parameters/Transition/transition_request", "Idle")

func _process(_delta: float) -> void:
	if !dir_locked:
		set_dir()
	if player.velocity.normalized().x and %StateMachine.current_state.name.to_lower() == "idle" and player.velocity.normalized().y == 0:
		animation_tree.set("parameters/Transition/transition_request", "Running")



func set_idle_anims(state : State) -> void:
	if state.name.to_lower() != "idle":
		return
	dir_locked = false
	var y_dir = player.velocity.normalized().y
	if y_dir > 0:
		animation_tree.set("parameters/Transition/transition_request", "Falling")
	elif y_dir < 0:
		animation_tree.set("parameters/Transition/transition_request", "Jumping")
	else:
		animation_tree.set("parameters/Transition/transition_request", "Idle")
	

func on_state_changed(state: State):
	if state.name.to_lower() == "idle":
		set_idle_anims(state)
		return
	dir_locked = true
	if state.name.to_lower() == "attacking":
		animation_tree.set("parameters/Transition/transition_request", $"../StateMachine/Attacking".current_attack)
	elif state.name.to_lower() == "parrying":
		animation_tree.set("parameters/Transition/transition_request", "Parrying")
	elif state.name.to_lower() == "dashing":
		animation_tree.set("parameters/Transition/transition_request", "Dashing")

func set_dir():
	var direction = player.direction
	if direction < 0 and player.knockback_velocity == 0:
		$"../Sprite2D".scale.x = -1.0
	elif direction > 0:
		$"../Sprite2D".scale.x = 1.0


func on_player_jumped():
	if %StateMachine.current_state.name.to_lower() != "idle":
		return
	animation_tree.set("parameters/Transition/transition_request", "Jumping")

func on_player_falling():
	if %StateMachine.current_state.name.to_lower() != "idle":
		return
	animation_tree.set("parameters/Transition/transition_request", "Falling")

func on_player_grounded():
	if %StateMachine.current_state.name.to_lower() != "idle":
		return
	animation_tree.set("parameters/Transition/transition_request", "Idle")
