extends Node

# ensure this node is accessible by unique name when using hurtbox

@export var stats : Stats
@export var target : CharacterBody2D

var hit_flash_time : float = 0.1

func _ready() -> void:
	stats.health_depleted.connect(_on_health_depleted)

func _on_experience_gained(xp_gained : int):
	stats._on_experience_set(stats.experience + xp_gained)

func _on_health_depleted():
	if target.has_method("_on_death"):
		target._on_death()

func take_damage(source) -> void:
	if %StateMachine.current_state.name.to_lower() == "parrying":
		%StateMachine.current_state.parry_success(source)
		$"../Sounds/ParrySuccessful".play(0.7)
		source.target.parried()
		Globals.frame_freeze(0.05, 0.4)
		return
	
	Globals.frame_freeze(0.05, 0.2)
	
	if target.has_method("take_knockback"):
		target.take_knockback()
	
	# integer division in gdscript discards decimal part
	# which is intended in this case
	@warning_ignore("integer_division")
	var dmg_taken = source.stats.current_attack / (1 + (stats.current_defense/100))
	if dmg_taken <= 0:
		dmg_taken = 1
	Globals.create_damage_label(str(dmg_taken), target.position)
	
	var new_health = stats.health - dmg_taken
	stats._on_health_set(new_health)
	
	#play hitflash
	if target.is_in_group("Enemy"):
		Globals.hitflash($"../Sprite2D".material, 1)
	
