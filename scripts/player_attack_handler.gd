extends Node2D

const hitbox_scene = preload("res://scenes/player_attack_hitbox.tscn")
@export var vfx_scene : PackedScene

const X_OFFSET : int = 75
const Y_OFFSET : int = 100

@export var dmg : float = 20.0

func do_attack(direction):
	# make hitbox
	var hitbox = hitbox_scene.instantiate()
	var vfx = vfx_scene.instantiate()
	var player = get_parent()
	player.add_child(hitbox)
	player.add_child(vfx)
	vfx.scale = $"../Sprite".scale
	if get_parent().dir_y < 0:
		hitbox.global_position = self.global_position + Vector2(0, Y_OFFSET)
		vfx.global_position = self.global_position + Vector2(0, Y_OFFSET)
	elif get_parent().dir_y > 0:
		hitbox.global_position = self.global_position + Vector2(0, -Y_OFFSET)
		vfx.global_position = self.global_position + Vector2(0, -Y_OFFSET)
	elif direction < 0:
		hitbox.global_position = self.global_position + Vector2(-X_OFFSET, 0)
		vfx.global_position = self.global_position + Vector2(-X_OFFSET, 0)
	else:
		hitbox.global_position = self.global_position + Vector2(X_OFFSET, 0)
		vfx.global_position = self.global_position + Vector2(X_OFFSET, 0)
	# sets hitbox dmg
	hitbox.dmg = dmg
	hitbox.source = get_parent()
