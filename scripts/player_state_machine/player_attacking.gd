extends State
class_name PlayerAttacking

var attack_combo = {
	0 : "AttackDown",
	1 :  "AttackUp",
	2 :  "AttackDiagonal"
}
enum attack_states {
	AttackDown, AttackUp, AttackDiagonal
}

var current_state : int = 0

var current_attack : String = attack_combo[current_state]

var is_attacking: bool = false
var buffered_attack : bool = false

const ATTACK_SPEED : float = 0.42

var current_attack_speed : float = 0.42

func Enter():
	if !$ComboTimer.is_stopped() and !buffered_attack:
		current_state += 1
	buffered_attack = false
	if current_state >= 3:
		current_state = 0
	current_attack_speed = ATTACK_SPEED
	current_attack = attack_combo[current_state]

	var player = get_tree().get_first_node_in_group("Player")
	$"../../Sounds/AttackSound".play(0.2)
	%AttackHandler.do_attack(player.direction)
	is_attacking = true
	$ComboTimer.start()
	#$BufferTimer.start()
	await get_tree().create_timer(current_attack_speed).timeout
	
	is_attacking = false
	if buffered_attack:
		if current_state + 1 >= 3:
			Transitioned.emit(self, "idle")
		current_state += 1
		Transitioned.emit(self, "attacking")
	else:
		Transitioned.emit(self, "idle")

func _on_attack_input():
	if !$ComboTimer.is_stopped():
		buffered_attack = true


func _on_combo_timer_timeout() -> void:
	current_state = 0
