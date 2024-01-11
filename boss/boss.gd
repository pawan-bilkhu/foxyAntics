extends Node2D


const TRIGGER_CONDITION: String = "parameters/conditions/on_trigger"
const ON_HIT_CONDITION: String = "parameters/conditions/on_hit"

@onready var animation_tree = $AnimationTree
@onready var visual_elements = $VisualElements


@export var lives: int = 2
@export var points: int = 5


var _invicible: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func blend_hit_transtion() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(visual_elements, "position", Vector2.ZERO, 1.0)


func remove_lives() -> void:
	lives -= 1
	if lives <= 0:
		SignalManager.on_boss_destroyed.emit()
		print("Boss Destroyed")
		set_process(false)
		queue_free()


func set_invincibility(value: bool) -> void:
	_invicible = value
	animation_tree[ON_HIT_CONDITION] = value


func _on_trigger_area_entered(area):
	if not animation_tree[TRIGGER_CONDITION]:
		animation_tree[TRIGGER_CONDITION] = true


func take_damage() -> void:
	if _invicible:
		return
	set_invincibility(true)
	blend_hit_transtion()
	remove_lives()


func _on_hit_box_area_entered(area):
	take_damage()
