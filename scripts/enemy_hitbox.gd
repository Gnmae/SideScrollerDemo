class_name Hitbox extends Area2D

var source 

@export var dmg : float = 0.0
@export var timeScale : float = 0.05
@export var duration : float = 0.02

func _ready() -> void:
	await get_tree().create_timer(duration).timeout
	self.queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(source)
		self.queue_free()

func parried() -> void:
	if source.has_method("parried"):
		source.parried()
