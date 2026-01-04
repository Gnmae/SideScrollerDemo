extends State
class_name PlayerIdle

@export var player : CharacterBody2D

func Update(_delta: float):
	if Input.is_action_just_pressed("Attack"):
		Transitioned.emit(self, "attacking")
	elif Input.is_action_just_pressed("Parry"):
		Transitioned.emit(self, "parrying")
	elif $"../Dashing/DashCooldownTimer".time_left == 0 and Input.is_action_just_pressed("Dash"):
		Transitioned.emit(self, "dashing")
