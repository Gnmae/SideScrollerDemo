class_name MovementCommand
extends Command

class Params:
	var input: Vector2
	
	func _init(input: Vector2) -> void:
		self.input = input

func execute(player: Player, data: Object = null) -> void:
	if data is Params:
		player.move(data.input)
