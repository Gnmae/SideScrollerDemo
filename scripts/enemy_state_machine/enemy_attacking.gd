extends State

@export var enemy: CharacterBody2D

var parried : bool = false

func Enter():
	parried = false
	await get_tree().create_timer(0.35).timeout
	$"../../EnemyWeapon".do_attack(enemy.direction)
	$"../../AttackSound".play(0.25)
	await get_tree().create_timer(0.2).timeout
	if parried:
		Transitioned.emit(self, "parried")
	else:
		Transitioned.emit(self, "wait")
