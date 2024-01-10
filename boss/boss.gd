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


func _on_trigger_area_entered(area):
	if not animation_tree[TRIGGER_CONDITION]:
		animation_tree[TRIGGER_CONDITION] = true
