class_name InteractCommand
extends Command

func execute(player: Player, _data: Object = null) -> void:
	player.interact()
