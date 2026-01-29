class_name vfx extends Node

@export var duration : float

func _ready() -> void:
	await get_tree().create_timer(duration).timeout
	self.queue_free()
