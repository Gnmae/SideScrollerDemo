extends Control


func _on_player_stats_changed(health, max_health) -> void:
	%HealthBar.max_value = max_health
	%HealthBar.value = health
