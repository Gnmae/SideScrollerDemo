extends Node2D

const hitbox_scene = preload("res://scenes/player_attack_hitbox.tscn")
const X_OFFSET : int = 75
const Y_OFFSET : int = 100

@export var dmg : float = 20.0

func do_attack(direction):
	# make hitbox
	var hitbox = hitbox_scene.instantiate()
	get_parent().add_child(hitbox)
	if get_parent().dir_y < 0:
		hitbox.global_position = self.global_position + Vector2(0, Y_OFFSET)
	elif get_parent().dir_y > 0:
		hitbox.global_position = self.global_position + Vector2(0, -Y_OFFSET)
	elif direction < 0:
		hitbox.global_position = self.global_position + Vector2(-X_OFFSET, 0)
	else:
		hitbox.global_position = self.global_position + Vector2(X_OFFSET, 0)
	# sets hitbox dmg
	hitbox.dmg = dmg
	hitbox.source = get_parent()
