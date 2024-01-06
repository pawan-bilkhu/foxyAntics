extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D

const FRUITS: Array = ["banana", "cherry", "kiwi", "melon"]
const GRAVITY: float = 160
const JUMP_VELOCITY: float = -80.0
const POINTS: int = 2

var _starting_position_y: float
var _velocity_y: float = JUMP_VELOCITY
var _is_stopped: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_starting_position_y = global_position.y
	animated_sprite_2d.play(FRUITS.pick_random())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _is_stopped:
		return
	
	position.y += _velocity_y * delta
	_velocity_y += GRAVITY * delta
	
	if global_position.y > _starting_position_y:
		_is_stopped = true


func destroy() -> void:
	set_process(false)
	hide()
	queue_free()


func _on_life_span_timer_timeout():
	destroy()


func _on_area_entered(area):
	print("Got fruit pick up")
	SignalManager.on_fruit_pick_up_hit.emit(POINTS)
	destroy()
