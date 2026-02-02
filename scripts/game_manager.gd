extends Node2D

var levels = []
var current_room

@onready var player : Player = get_tree().get_first_node_in_group("Player")

var room1 : String = "uid://b5ycfw1uxfevl"

func _ready() -> void:
	load_room(room1)

#--------------------
# LEVEL MANAGEMENT
#--------------------
func load_room(room_scene_uid: String) -> void:
	if current_room:
		current_room.queue_free()
	
	# change room
	current_room = load(room_scene_uid).instantiate()
	add_child(current_room)
	current_room.name = "RoomRoot"
	player.global_position = current_room.left_pos.global_position
	
	setup_room()
	

func setup_room() -> void:
	# connect exit
	var exit = current_room.get_node_or_null("Exit")
	if exit:
		exit.Exit_Triggered.connect(on_exit_body_entered)
	
	player.can_move = true

#--------------------
# SIGNAL HANDLERS
#--------------------
func on_exit_body_entered(body : Node2D, scene_uid : String) -> void:
	if body.is_in_group("Player"):
		body.can_move = false
		call_deferred("load_room", scene_uid)
	
