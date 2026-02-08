extends State

const DEFAULT_PARRY_WINDOW : float = 0.2
const PERFECT_PARRY_WINDOW : float = 0.133

const PERFECT_PARRY_FREEZE_TIME : float = 1.0
const NORMAL_PARRY_FREEZE_TIME : float = 0.3

var parry_window : float = 0.2

func Enter():
	$ParryTimer.wait_time = parry_window
	$ParryTimer.start()
	$"../../Sounds/ParryStart".play(0.15)
	await get_tree().create_timer(parry_window).timeout
	Transitioned.emit(self, "idle")

func parry_success(source) -> void:
	if $ParryTimer.time_left <= PERFECT_PARRY_WINDOW:
		$"../../Sounds/ParrySuccessful".play(0.7)
		source.target.parried()
		print("perfect parry")
		Globals.frame_freeze(0.05, PERFECT_PARRY_FREEZE_TIME)
	elif $ParryTimer.time_left:
		$"../../Sounds/ParrySuccessful".play(0.7)
		source.target.parried()
		print("normal parry")
		Globals.frame_freeze(0.05, NORMAL_PARRY_FREEZE_TIME)
