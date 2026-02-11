extends Node2D

var levels = []
var current_room
var transition_time : float = 1.0

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
	%FadeToBlackObject.color = Color(0, 0, 0, 1.0)
	# connect exit
	var exit = current_room.get_node_or_null("ExitArea")
	if exit:
		exit.Exit_Triggered.connect(on_exit_body_entered)
	# connect enemy killed signals
	if current_room.has_method("update_enemy_count"):
		var enemies = current_room.update_enemy_count()
		for enemy in enemies:
			enemy.Killed.connect(on_enemy_death)
	# set room reward
	var reward_scene = load("uid://brxpjoopqn76u") # load reward_scene
	var new_reward_uid = decide_reward()
	current_room.reward_uid = new_reward_uid
	current_room.reward_scene = reward_scene
	
	
	# fades from black and allow player to move
	var tween = get_tree().create_tween()
	tween.tween_property(%FadeToBlackObject, "color", Color(0, 0, 0, 0.0), transition_time)
	await tween.finished
	player.can_move = true
	

#--------------------
# SIGNAL HANDLERS
#--------------------
func on_exit_body_entered(body : Node2D, scene_uid : String) -> void:
	if body.is_in_group("Player"):
		body.can_move = false
		call_deferred("load_room", scene_uid)
	

func on_enemy_death(enemy) -> void:
	current_room.update_enemy_count(enemy)

#--------------------
# REWARD DICTIONARY AND FUNCTIONS
#--------------------

var reward_dictionary = {
	0 : "uid://2ofknp88xk0g", # attack increase
	1 : "uid://doyxn5qlauefm" # health increase
}

func decide_reward() -> String:
	var index = randi_range(0, reward_dictionary.size() -1)
	return reward_dictionary[index]
