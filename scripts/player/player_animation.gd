extends Node

@export var animation_tree: AnimationTree
@export var player : CharacterBody2D

var dir_locked : bool = false

var idle : int = 0
var running : int = 1
var falling : int = 2
var jumping : int = 3
var non_idle : int = 4

var states : Dictionary = {
	idle : "Idle",
	running : "Running",
	falling : "Falling",
	jumping : "Jumping",
	non_idle : "non-idle"
}

var current_state : String

@warning_ignore("unused_parameter")
func _ready() -> void:
	current_state = states[idle]
	#print(current_state)
	## connect signals for anim changes
	#%StateMachine.StateChanged.connect(on_state_changed)
	#player.PlayerJumped.connect(on_player_jumped)
	#player.PlayerFalling.connect(on_player_falling)
	#player.PlayerGrounded.connect(on_player_grounded)
	#
	## set base anims for no input
	#var y_dir = player.velocity.normalized().y
	#if y_dir > 0:
		#animation_tree.set("parameters/Transition/transition_request", "Falling")
	#elif y_dir < 0:
		#animation_tree.set("parameters/Transition/transition_request", "Jumping")
	#else:
		#animation_tree.set("parameters/Transition/transition_request", "Idle")

func _process(_delta: float) -> void:
	if !dir_locked:
		set_dir()
	#if current_state != states[non_idle]:
		#if animation_tree.get("parameters/Transition/current_state") != current_state:
			#animation_tree.set("parameters/Transition/transition_request", current_state)
		#if player.is_on_floor():
			#if player.velocity.x:
				#current_state = states[running]
			#else:
				#current_state = states[idle]
		#else:
			#if player.velocity.y > 0:
				#current_state = states[jumping]
			#else:
				#current_state = states[falling]
	#


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
		dir_locked = false
		return
	current_state = states[non_idle]
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
	if current_state != states[non_idle]:
		current_state = states[jumping]

func on_player_falling():
	if current_state != states[non_idle]:
		current_state = states[falling]

func on_player_grounded():
	if current_state != states[non_idle]:
		current_state = states[jumping]
