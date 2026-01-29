extends Node

# ensure this node is accessible by unique name when using hurtbox

@export var stats : Stats

func _on_experience_gained(xp_gained : int):
	stats._on_experience_set(stats.experience + xp_gained)

func take_damage(amt : int, source):
	pass
