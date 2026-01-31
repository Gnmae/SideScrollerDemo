class_name ParryCommand extends Command

func execute(player: Player, data: Object = null) -> void:
	if player.state_machine.current_state.name.to_lower() == "idle":
		player.state_machine.current_state._on_parry_input()
