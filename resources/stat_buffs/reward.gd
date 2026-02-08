class_name RewardInteractable extends Interactable

@export var reward_uid : String
@export var reward_text : String

@onready var reward : StatBuff = load(reward_uid)

var reward_picked_up : bool = false

func interact(_player : Player):
	if !reward_picked_up:
		var player_stats = load("uid://cnyfatddqnxp2")
		player_stats.add_buff(reward)
		self.queue_free()
