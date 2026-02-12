extends State
class_name PlayerIdle

@export var player : CharacterBody2D
@export var anim_player : AnimationPlayer

func _on_attack_input():
	if player.is_on_floor():
		Transitioned.emit(self, "attacking")

func _on_parry_input():
	Transitioned.emit(self, "parrying")

func _on_dash_input():
	if $"../Dashing/DashCooldownTimer".time_left == 0:
		Transitioned.emit(self, "dashing")

func Update(_delta: float) -> void:
	if player.is_on_floor():
		if player.velocity.x:
			if anim_player.current_animation != "run":
				anim_player.play("run")
		else:
			anim_player.play("idle")
	else:
		if player.velocity.y > 0:
			anim_player.play("falling")
		else:
			anim_player.play("jumping")
