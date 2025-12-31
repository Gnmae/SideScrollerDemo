class_name HurtBox extends Area2D

func take_damage(amt : float, source):
	var parent = get_parent()
	parent.take_damage(amt, source)
