class_name JumpCommand
extends Command

func execute(player: Player, _data: Object = null):
	player.jump()
