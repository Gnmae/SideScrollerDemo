extends Control

@onready var blur_amount = $ColorRect.material.get_shader_parameter("blur_amount")

var default_blur_amount : float = 1.5

func _on_return_to_game_button_pressed() -> void:
	Globals.close_options()

func _on_exit_to_desktop_button_pressed() -> void:
	get_tree().quit()

func blur_in():
	$ColorRect.material.set_shader_parameter("blur_amount", default_blur_amount)

func blur_out():
	$ColorRect.material.set_shader_parameter("blur_amount", 0.0)
