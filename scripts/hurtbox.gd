class_name HurtBox extends Area2D

@onready var stats_handler = %StatsHandler
@onready var stats = stats_handler.stats

func take_damage(amt : float, source):
	if stats.has_method("take_damage"):
		stats.take_damage(amt, source)

func take_effect(amt : int, effect : Effect):
	if stats.has_method("add_buff"):
		stats.take_effect(amt, effect)
