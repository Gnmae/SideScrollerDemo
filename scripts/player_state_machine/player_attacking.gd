extends State
class_name PlayerAttacking

@export var player : Player
@export var anim_player : AnimationPlayer

#region attack vars
var attack_combo = {
	0 : "attack_down",
	1 :  "attack_up",
	2 :  "attack_diagonal"
}

var current_state : int = 0

var current_attack : String = attack_combo[current_state]

var is_attacking: bool = false
var buffered_attack : bool = false

const ATTACK_SPEED : float = 0.42

var current_attack_speed : float = 0.42
#endregion

func Enter():
	player.can_move = false
	if !$ComboTimer.is_stopped() and !buffered_attack:
		current_state += 1
	buffered_attack = false
	if current_state >= 3:
		current_state = 0
	current_attack_speed = ATTACK_SPEED
	current_attack = attack_combo[current_state]

	%AudioManager.play_attack_sound()
	%AttackHandler.do_attack(player.direction)
	is_attacking = true
	$ComboTimer.start()
	anim_player.play(current_attack)
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

func Exit() -> void:
	player.can_move = true
