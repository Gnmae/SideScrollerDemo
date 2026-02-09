extends Area2D

const trick_effect = preload("res://effects/trick.tscn")

var source
var timeScale : float = 0.05
var duration : float = 0.3

func _ready() -> void:
	await get_tree().create_timer(0.2).timeout
	self.queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(source)
		if area.has_method("take_effect"):
			area.take_effect(1, create_effect())
		get_tree().get_first_node_in_group("Player").take_knockback()
		self.queue_free()

func create_effect():
	var new_effect = trick_effect.instantiate()
	get_parent().add_child(new_effect)
	return new_effect
