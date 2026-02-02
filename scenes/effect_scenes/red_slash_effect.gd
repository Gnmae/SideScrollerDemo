extends Node2D

@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var Sprite : Sprite2D = $Sprite2D

func down_slash():
	anim.play("down_slash")

func up_slash():
	anim.play("up_slash")
