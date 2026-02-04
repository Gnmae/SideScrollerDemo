extends CharacterBody2D

signal Killed

var direction : int = 1

var knockback_velocity : float = 0.0

var effects : Array[Effect] = []

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

func take_effect(amt : int, effect : Effect):
	var index = find_effect(effect) # returns -1 if not found
	if index != -1:
		effects[index].increase_stack_amt(amt)
	else:
		effects.append(effect)
		effect.reparent(self)
		index = effects.find(effect)
		effects[index].increase_stack_amt(amt)
	for i in effects:
		print(i.name + " amt: " + str(i.stacks))

func parried():
	$StateMachine/Attacking.parried = true

func find_effect(effect : Effect):
	if effects.is_empty():
		return -1
	for i in range(0, effects.size()):
		if effects[i].is_class(effect.get_class()):
			return i
		else:
			return -1

func activate_effect(effect: Effect):
	var index = find_effect(effect)
	if index != -1:
		effect.activate()
	effects.remove_at(index)
	effect.queue_free()

func _on_death():
	Killed.emit(self)
	self.queue_free()
