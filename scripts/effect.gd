class_name Effect extends Node

@warning_ignore("unused_parameter")
func increase_stack_amt(amt: int):
	pass

@warning_ignore("unused_parameter")
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
