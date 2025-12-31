extends State

@export var enemy: CharacterBody2D

var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(_delta: float):
	var direction = player.global_position - enemy.global_position
	
	enemy.velocity = Vector2(0, 0)
	
	if direction.length() < 100.0:
		Transitioned.emit(self, "chasing")
