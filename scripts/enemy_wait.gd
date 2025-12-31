extends State

const WAIT_TIME : float = 1.0

func Enter():
	await get_tree().create_timer(WAIT_TIME).timeout
	Transitioned.emit(self, "idle")
