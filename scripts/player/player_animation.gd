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
	elif $"../StateMachine".current_state.name.to_lower() == "dashing":
		animation_tree.set("parameters/conditions/dashing", true)
		return
	else:
		animation_tree.set("parameters/conditions/parrying", false)
		animation_tree.set("parameters/conditions/attacking", false)
		animation_tree.set("parameters/conditions/dashing", false)
	
	var direction = player.velocity.normalized().x
	if direction < 0 and player.knockback_velocity == 0:
		$"../Sprite".scale.x = -1.0
	elif direction > 0:
		$"../Sprite".scale.x = 1.0
	var y_dir = player.velocity.normalized().y
	if Input.is_action_pressed("up_arrow"):
		if $"../Sprite".scale.x == -1.0:
			pass
		else:
			pass
	elif Input.is_action_pressed("down_arrow") and y_dir != 0:
		if $"../Sprite".scale.x == -1.0:
			pass
		else:
			pass
	else:
		pass
	
