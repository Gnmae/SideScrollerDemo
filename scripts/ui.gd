extends Control

@export var player_stats : Stats = preload("res://resources/player_stats.tres")

func _ready() -> void:
	player_stats.health_changed.connect(_on_player_health_changed)
	_on_player_health_changed(player_stats.health, player_stats.current_max_health)

@warning_ignore("unused_parameter")
func _on_player_health_changed(health, max_health) -> void:
	%HealthBar.max_value = max_health
	%HealthBar.value = health
	%HealthBar/Label.text = str(health) + "/" + str(max_health)
