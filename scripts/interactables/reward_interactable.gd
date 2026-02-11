class_name RewardInteractable extends Interactable

var reward : StatBuff 
@export var text_label: RichTextLabel
@export var sprite_2d: Sprite2D 

var reward_picked_up : bool = false

func set_reward(input_reward_uid : String, texture_2d_uid : String) -> void:
	reward = load(input_reward_uid)
	text_label.text = reward.description
	sprite_2d.texture = load(texture_2d_uid)

func interact(_player : Player) -> void:
	if !reward_picked_up:
		var player_stats = load("uid://cnyfatddqnxp2")
		player_stats.add_buff(reward)
		self.queue_free()

func _on_interaction_range_entered(_body : CharacterBody2D) -> void:
	super(_body)
	$Panel.visible = true

func _on_interaction_range_exited(_body : CharacterBody2D) -> void:
	super(_body)
	$Panel.visible = false
