extends State
class_name PlayerIdle

@export var player : CharacterBody2D

func _on_attack_input():
	Transitioned.emit(self, "attacking")

func _on_parry_input():
	Transitioned.emit(self, "parrying")

func _on_dash_input():
	if $"../Dashing/DashCooldownTimer".time_left == 0:
		Transitioned.emit(self, "dashing")
