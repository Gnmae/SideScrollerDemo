extends Control


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("uid://d1xahwlq1lgdi"))


func _on_quit_button_pressed() -> void:
	get_tree().quit()
