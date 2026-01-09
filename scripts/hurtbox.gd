class_name HurtBox extends Area2D

func take_damage(amt : float, source):
	var parent = get_parent()
	if parent.has_method("take_damage"):
		parent.take_damage(amt, source)

func take_effect(amt : int, effect : Effect):
	var parent = get_parent()
	if parent.has_method("take_effect"):
		parent.take_effect(amt, effect)
