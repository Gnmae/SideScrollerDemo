extends State

const DASH_WINDOW : float = 0.2  # seconds
const DASH_VELOCITY : float = 800.0
const DASH_COOLDOWN : float = 0.6 # seconds

@export var player : Player
@export var anim_player : AnimationPlayer

func Enter():
	$DashCooldownTimer.start(DASH_COOLDOWN)
	anim_player.play("dash")
	player.velocity.y = 0
	player.velocity.x = player.direction * DASH_VELOCITY
	await get_tree().create_timer(DASH_WINDOW).timeout
	Transitioned.emit(self, "idle")
