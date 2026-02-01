class_name PlayerController
extends InputHandler

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		attack_command.execute(player)
	
	var horizontal_input = Input.get_axis("move_left", "move_right")
	var vertical_input = Input.get_axis("move_down", "move_up")
	var movement_input = Vector2(horizontal_input, vertical_input)
	movement_command.execute(player, MovementCommand.Params.new(movement_input))
	
	if Input.is_action_just_pressed("Jump"):
		jump_command.execute(player)
	
	if Input.is_action_just_pressed("Parry"):
		parry_command.execute(player)
	
	if Input.is_action_just_pressed("Dash"):
		dash_command.execute(player)
