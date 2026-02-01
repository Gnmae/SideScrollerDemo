class_name InputHandler extends Node

var player : Player

var movement_command := MovementCommand.new()
var attack_command := AttackCommand.new()
var jump_command := JumpCommand.new()
var parry_command := ParryCommand.new()
var dash_command := DashCommand.new()

func _init(_player: Player) -> void:
	self.player = _player
