class_name Interactable
extends Node2D

var interacted : bool = false

func _ready() -> void:
	$InteractArea.connect("body_entered", _on_interaction_range_entered)
	$InteractArea.connect("body_exited", _on_interaction_range_exited)


@warning_ignore("unused_parameter")
func interact(player : Player) -> void:
	pass

func _on_interaction_range_entered(_body : CharacterBody2D):
	if !interacted and _body is Player:
		var player = _body
		player.interactables.push_front(self)
		print(player.interactables)

func _on_interaction_range_exited(_body : CharacterBody2D):
	if !interacted and _body is Player:
		var player = _body
		player.interactables.erase(self)
		print(player.interactables)
