extends CharacterBody2D

var direction : int = 1

var knockback_velocity : float = 0.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var player = get_tree().get_first_node_in_group("Player")
	direction = player.global_position.x - self.global_position.x
	
	if direction < 0:
		$EnemyWeapon.position = Vector2(-14, -1)
	else:
		$EnemyWeapon.position = Vector2(14, -1)
	
	move_and_slide()

func take_damage(amt : float, _source):
	print(amt)

func parried():
	$StateMachine/Attacking.parried = true
