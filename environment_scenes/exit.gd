class_name ExitArea extends Area2D

@export var next_area : String

signal Exit_Triggered

func _on_body_entered(body: Node2D) -> void:
	Exit_Triggered.emit(body, next_area)
