class_name Reward extends Node2D

@export var reward_uid : String

@onready var reward : StatBuff = load(reward_uid)

var reward_picked_up : bool = false

func _ready() -> void:
	$CollectionArea.connect("body_entered", _on_pickup)

func _on_pickup(_body : CharacterBody2D):
	if !reward_picked_up:
		var player_stats = load("uid://cnyfatddqnxp2")
		player_stats.add_buff(reward)
		self.queue_free()
