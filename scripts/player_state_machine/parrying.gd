extends State

const PARRY_WINDOW : float = 0.2

func Enter():
	$"../../Sounds/ParryStart".play(0.15)
	await get_tree().create_timer(PARRY_WINDOW).timeout
	Transitioned.emit(self, "idle")
