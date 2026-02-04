extends Label

func _ready() -> void:
	var damage_label_tween = get_tree().create_tween()
	damage_label_tween.set_parallel(true)
	damage_label_tween.tween_property(self, "position:y", global_position.y - 80, 2.0)
	await damage_label_tween.finished
	queue_free()
