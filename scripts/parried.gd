extends State

func Enter():
	await get_tree().create_timer(1.0).timeout
	Transitioned.emit(self, "wait")
