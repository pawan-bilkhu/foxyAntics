extends CharacterBody2D

class_name EnemyBase

enum FACING { LEFT = -1 , RIGHT = 1 }


const SCREEN_HEIGHT_TOLERANCE: float = 1000.0

@export var default_facing: FACING = FACING.LEFT
@export var points: int = 1
@export var speed: float = 30.0


var _gravity: float = 800.0
var _facing: FACING = default_facing
var _player_reference: Player
var _is_dead: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	_player_reference = get_tree().get_nodes_in_group(GameManager.GROUP_PLAYER)[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	fallen_off()


func fallen_off() -> void:
	if global_position.y > SCREEN_HEIGHT_TOLERANCE:
		queue_free()


func remove() -> void:
	if _is_dead:
		return
	
	_is_dead = true
	SignalManager.on_enemy_hit.emit(points, global_position)
	set_physics_process(false)
	hide()
	queue_free()



func _on_visible_on_screen_notifier_2d_screen_entered():
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.
