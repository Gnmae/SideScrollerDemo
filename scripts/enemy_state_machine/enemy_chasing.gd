extends State

@export var enemy : CharacterBody2D

const SPEED = 100.0

var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(_delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 50.0:
		enemy.velocity.x = SPEED * direction.normalized().x
	else:
		enemy.velocity = Vector2(0, 0)
	
	if direction.length() < 50.0:
		Transitioned.emit(self, "attacking")
	
	if direction.length() > 100.0:
		Transitioned.emit(self, "idle")
