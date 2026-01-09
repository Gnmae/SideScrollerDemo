extends State
class_name PlayerAttacking

const ATTACK_SPEED : float = 0.42

func Enter():
	var player = get_parent().get_parent()
	$"../../Sounds/AttackSound".play(0.2)
	%AttackHandler.do_attack(player.direction)
	await get_tree().create_timer(ATTACK_SPEED).timeout
	Transitioned.emit(self, "idle")
