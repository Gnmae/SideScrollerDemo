class_name AttackCommand
extends Command


func execute(player : Player, _data: Object = null) -> void:
	if player.state_machine.current_state.name.to_lower() == "idle":
		player.state_machine.current_state._on_attack_input()
	elif player.state_machine.current_state.name.to_lower() == "attacking":
		player.state_machine.current_state._on_attack_input()
