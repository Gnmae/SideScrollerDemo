extends State

const DASH_WINDOW : float = 0.2  # seconds
const DASH_VELOCITY : float = 1750.0
const DASH_COOLDOWN : float = 0.6 # seconds

@export var player : CharacterBody2D

func Enter():
	$DashCooldownTimer.start(DASH_COOLDOWN)
	player.velocity.y = 0
	player.velocity.x = player.direction * DASH_VELOCITY
	await get_tree().create_timer(DASH_WINDOW).timeout
	Transitioned.emit(self, "idle")
