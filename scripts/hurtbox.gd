class_name HurtBox extends Area2D

@onready var stats_handler = %StatsHandler

func take_damage(source):
	if stats_handler.has_method("take_damage"):
		stats_handler.take_damage(source)

func take_effect(amt : int, effect : Effect):
	if stats_handler.has_method("add_buff"):
		stats_handler.take_effect(amt, effect)
