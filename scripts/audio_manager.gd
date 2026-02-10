extends Node2D

@export var player : Player

#region sounds
@onready var footstep : AudioStreamPlayer2D = $Footstep
@onready var jump: AudioStreamPlayer2D = $Jump
@onready var attack: AudioStreamPlayer2D = $Attack
@onready var parry: AudioStreamPlayer2D = $Parry
@onready var grounded: AudioStreamPlayer2D = $Grounded
@onready var player_hurt: AudioStreamPlayer2D = $PlayerHurt
@onready var hitsound: AudioStreamPlayer2D = $Hitsound
@onready var dash: AudioStreamPlayer2D = $Dash

#endregion

func _ready() -> void:
	player.PlayerJumped.connect(play_jump_sound)

var land_sound_played : bool = false

func _process(_delta: float) -> void:
	if player.is_on_floor() and !land_sound_played:
		land_sound_played = true
		play_grounded_sound()
	elif player.velocity.y != 0:
		land_sound_played = false

func play_dash_sound():
	dash.play()

func play_hit_sound():
	hitsound.play()

func play_hurt_sound():
	player_hurt.play()

func play_footstep_sound():
	footstep.play()

func play_parry_sound():
	parry.play()

func play_jump_sound():
	jump.play()

func play_grounded_sound():
	grounded.play()

func play_attack_sound():
	attack.play()
