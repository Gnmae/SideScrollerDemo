extends Node2D

const hitbox_scene = preload("res://scenes/player_attack_hitbox.tscn")

const X_OFFSET : int = 32
const Y_OFFSET : int = 70

@export var dmg : float = 20.0

#@onready var vfx_controller = $"../RedSlashEffect"

func do_attack(direction):
	# make hitbox
	var hitbox = hitbox_scene.instantiate()
	hitbox.source = %StatsHandler
	var player = get_parent()
	player.add_child(hitbox)
	#vfx_controller.down_slash()
	if player.dir_y < 0:
		hitbox.global_position = self.global_position + Vector2(0, Y_OFFSET)
		#vfx_controller.global_position = self.global_position + Vector2(0, Y_OFFSET)
	elif player.dir_y > 0:
		hitbox.global_position = self.global_position + Vector2(0, -Y_OFFSET)
		#vfx_controller.global_position = self.global_position + Vector2(0, -Y_OFFSET)
	elif direction < 0:
		hitbox.global_position = self.global_position + Vector2(-X_OFFSET, 0)
		#vfx_controller.global_position = self.global_position + Vector2(-X_OFFSET, 0)
		#vfx_controller.Sprite.flip_h = true
		
		#var animation : Animation = vfx_controller.anim.get_animation("down_slash")
		#var duration : float = animation.length
		#vfx_controller.Sprite.position = Vector2(20, 0)
		#await get_tree().create_timer(duration).timeout
		#vfx_controller.Sprite.position = Vector2.ZERO
	else:
		hitbox.global_position = self.global_position + Vector2(X_OFFSET, 0)
		#vfx_controller.global_position = self.global_position + Vector2(X_OFFSET, 0)
		#vfx_controller.Sprite.flip_h = false
		
		#var animation : Animation = vfx_controller.anim.get_animation("down_slash")
		#var duration : float = animation.length
		#vfx_controller.Sprite.position = Vector2(-20, 0)
		#await get_tree().create_timer(duration).timeout
		#vfx_controller.Sprite.position = Vector2.ZERO
