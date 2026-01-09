class_name Effect extends Node

func increase_stack_amt(amt: int):
	pass

func decrease_stack_amt(amt: int):
	pass

func clear_stacks():
	pass

func activate():
	pass

func call_effect_activation():
	var parent = get_parent()
	if parent.has_method("activate_effect"):
		parent.activate_effect(self)
