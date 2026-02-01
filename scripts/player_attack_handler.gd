extends Node2D

const hitbox_scene = preload("res://scenes/player_attack_hitbox.tscn")
@export var vfx_scene : PackedScene

const X_OFFSET : int = 75
const Y_OFFSET : int = 100

@export var dmg : float = 20.0

func do_attack(direction):
	# make hitbox
	var hitbox = hitbox_scene.instantiate()
	var new_vfx = vfx_scene.instantiate()
	var player = get_parent()
	player.add_child(hitbox)
	player.add_child(new_vfx)
	new_vfx.scale = $"../Sprite".scale
	if player.dir_y < 0:
		hitbox.global_position = self.global_position + Vector2(0, Y_OFFSET)
		new_vfx.global_position = self.global_position + Vector2(0, Y_OFFSET)
	elif player.dir_y > 0:
		hitbox.global_position = self.global_position + Vector2(0, -Y_OFFSET)
		new_vfx.global_position = self.global_position + Vector2(0, -Y_OFFSET)
	elif direction < 0:
		hitbox.global_position = self.global_position + Vector2(-X_OFFSET, 0)
		new_vfx.global_position = self.global_position + Vector2(-X_OFFSET, 0)
	else:
		hitbox.global_position = self.global_position + Vector2(X_OFFSET, 0)
		new_vfx.global_position = self.global_position + Vector2(X_OFFSET, 0)
	# sets hitbox dmg
	hitbox.dmg = dmg
	hitbox.source = %StatsHandler
