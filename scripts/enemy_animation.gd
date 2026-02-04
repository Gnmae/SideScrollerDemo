extends Node

@export var enemy : CharacterBody2D
@export var animation_tree: AnimationTree


func _physics_process(_delta: float) -> void:
	if $"../StateMachine".current_state.name.to_lower() == "attacking":
		animation_tree.set("parameters/EnemyState/conditions/attacking", true)
		return
	elif $"../StateMachine".current_state.name.to_lower() == "parried":
		animation_tree.set("parameters/EnemyState/conditions/parried", true)
		animation_tree.set("parameters/EnemyState/conditions/attacking", false)
		return
	else:
		animation_tree.set("parameters/EnemyState/conditions/parried", false)
		animation_tree.set("parameters/EnemyState/conditions/attacking", false)
	
	var direction = enemy.velocity.normalized().x
	if direction < 0 and enemy.knockback_velocity == 0:
		$"../Sprite2D".flip_h = true
	elif direction > 0:
		$"../Sprite2D".flip_h = false
	
