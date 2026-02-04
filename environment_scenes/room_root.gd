class_name RoomRoot extends Node2D

@warning_ignore("unused_variable")
@export var left_pos : Node2D
@export var right_pos : Node2D

@export var enemy_count : int

var reward_scene : PackedScene

signal RoomCompleted

func _ready() -> void:
	RoomCompleted.connect(on_completion)

func on_completion():
	%Door.enabled = false
	
	var player_position = get_tree().get_first_node_in_group("Player").global_position
	var reward = reward_scene.instantiate()
	call_deferred("add_child", reward)
	reward.global_position = player_position
