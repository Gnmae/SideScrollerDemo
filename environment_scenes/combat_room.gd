class_name CombatRoom extends RoomRoot

var enemy_array = []

func update_enemy_count(enemy_removed = null):
	enemy_array = get_tree().get_nodes_in_group("Enemy")
	if enemy_array.has(enemy_removed):
		enemy_array.erase(enemy_removed)
	enemy_count = enemy_array.size()
	if enemy_count == 0:
		RoomCompleted.emit()
	
	return enemy_array
