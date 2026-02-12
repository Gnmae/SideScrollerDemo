extends ProgressBar

@export var target : Node

func _ready() -> void:
	self.max_value = target.stats.current_max_stagger
	self.value = target.stats.stagger
	target.stats.stagger_changed.connect(on_stagger_changed)

func on_stagger_changed():
	self.max_value = target.stats.current_max_stagger
	self.value = target.stats.stagger
