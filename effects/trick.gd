class_name Trick extends Effect
# effect on enemy
# each stack contains a number or value based off a randomly
# selected card from a standard 52-card deck + 2 jokers so 54.
# once reaching maximum stacks, this effect
# triggers dmg equal to the sum of the values
# of all stacks. The same card cannot be played
# twice

const MAX_STACKS = 4
var stacks : int = 0
var value_array : Array[float]

func increase_stack_amt(amt: int):
	for i in range(0, amt):
		stacks += 1 
		var value = generate_card_value()
		value_array.append(value)
	if stacks == 4:
		call_effect_activation()

func activate():
	var sum = 0
	for i in value_array:
		sum += i
	var parent = get_parent()
	if parent.has_method("take_damage"):
		parent.take_damage(sum, self)

func generate_card_value():
	# choose a number between 1-54. 2/54 and 1/54 represent joker
	# jokers add a value equal to each stacks value, added
	# to each other
	var value = 0
	var num = randi_range(1, 54)
	if num < 2:
		value = calculate_joker()
	else:
		num -= 2
		if num > 39:
			num -= 39
		elif num > 26:
			num -= 26
		elif num > 13:
			num -= 13
		value = num
	return value

func calculate_joker():
	var num = 0
	if value_array.is_empty():
		return num
	else:
		for i in value_array:
			num += i
	return num
