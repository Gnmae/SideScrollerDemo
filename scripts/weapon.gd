extends Node2D

const hitbox_scene = preload("res://scenes/hitbox.tscn")

@export var dmg : float = 20.0

func do_attack(direction):
	# make hitbox
	var hitbox = hitbox_scene.instantiate()
	get_parent().add_child(hitbox)
	if direction < 0:
		hitbox.global_position = self.global_position + Vector2(-20, 0)
	else:
		hitbox.global_position = self.global_position + Vector2(20, 0)
	# sets hitbox dmg
	hitbox.dmg = dmg
	hitbox.source = get_parent()
	# do attack animation
	do_anim(direction)

func do_anim(direction):
	var tween = get_tree().create_tween()
	if direction < 0:
		tween.tween_property($Sprite2D, "rotation_degrees", -120.0, 0.1).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property($Sprite2D, "rotation_degrees", 0.0, 0.1).set_trans(Tween.TRANS_BOUNCE)
	else:
		tween.tween_property($Sprite2D, "rotation_degrees", 120.0, 0.1).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property($Sprite2D, "rotation_degrees", 0.0, 0.1).set_trans(Tween.TRANS_BOUNCE)
