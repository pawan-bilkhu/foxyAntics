extends Area2D

const TRIGGER_CONDITION: String = "parameters/conditions/on_trigger"


@onready var animation_tree = $AnimationTree
@onready var sound_player = $SoundPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_boss_destroyed.connect(on_boss_destroyed)


func on_boss_destroyed() -> void:
	print("Checkpoint created")
	animation_tree[TRIGGER_CONDITION] = true
	monitoring = true
	SoundManager.play_clip(sound_player, SoundManager.SOUND_WIN)


func _on_area_entered(area):
	print("Level Complete")
