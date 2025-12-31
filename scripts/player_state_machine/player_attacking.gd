extends State
class_name PlayerAttacking

func Enter():
	var player = get_parent().get_parent()
	$"../../Sounds/AttackSound".play(0.2)
	%Weapon.do_attack(player.direction)
	await get_tree().create_timer(0.2).timeout
	Transitioned.emit(self, "idle")
