extends Node

func frame_freeze(timeScale, duration):
	Engine.time_scale = timeScale
	await get_tree().create_timer(duration * timeScale).timeout
	Engine.time_scale = 1

const DAMAGE_LABEL = preload("uid://clbhswjk2hq36")

func create_damage_label(input_text : String, position: Vector2):
	var new_damage_label = DAMAGE_LABEL.instantiate() as Label
	new_damage_label.text = input_text
	new_damage_label.global_position = position + Vector2(-25, -30)
	get_tree().current_scene.call_deferred("add_child", new_damage_label)

var hit_flash_time : float = 0.1

func hitflash(material : ShaderMaterial, flash_amt : int):
	for i in flash_amt:
		material.set_shader_parameter("hit_flash_on", true)
		await get_tree().create_timer(hit_flash_time).timeout
		material.set_shader_parameter("hit_flash_on", false)


func toggle_options():
	var options = get_tree().get_first_node_in_group("Options")
	if options.visible:
		close_options()
	else:
		open_options()

func open_options():
	var options = get_tree().get_first_node_in_group("Options")
	options.visible = true
	options.blur_in()

func close_options():
	var options = get_tree().get_first_node_in_group("Options")
	options.blur_out()
	options.visible = false
