extends Node

@export var animation_tree: AnimationTree
@export var player : CharacterBody2D


func _physics_process(delta: float) -> void:
	if $"../StateMachine".current_state.name.to_lower() == "attacking":
		animation_tree.set("parameters/conditions/attacking", true)
		return
	elif $"../StateMachine".current_state.name.to_lower() == "parrying":
		animation_tree.set("parameters/conditions/parrying", true)
		return
	else:
		animation_tree.set("parameters/conditions/parrying", false)
		animation_tree.set("parameters/conditions/attacking", false)
	
	var direction = player.velocity.normalized().x
	if direction < 0 and player.knockback_velocity == 0:
		$"../Sprite2D".flip_h = true
	elif direction > 0:
		$"../Sprite2D".flip_h = false
	
