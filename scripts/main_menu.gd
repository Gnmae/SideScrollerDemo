extends Control

@onready var click_sound: AudioStreamPlayer2D = $ClickSound

var delay : float = 0.2

func _on_play_button_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(delay).timeout
	get_tree().change_scene_to_packed(load("uid://d1xahwlq1lgdi"))


func _on_quit_button_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(delay).timeout
	get_tree().quit()


func _on_options_button_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(delay).timeout
