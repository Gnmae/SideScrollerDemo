extends Area2D

var dmg : float = 0.0
var source 

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	self.queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(dmg, source)
