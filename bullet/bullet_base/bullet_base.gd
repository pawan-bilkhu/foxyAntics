extends Area2D

var _direction: Vector2 = Vector2.RIGHT
var _life_span: float = 20.0
var _life_time: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	on_lifespan_zero(delta)
	position += _direction * delta


func on_lifespan_zero(delta: float) -> void:
	_life_time -= delta
	if _life_time <= 0:
		queue_free()

func initialize_bullet(direction: Vector2, life_span: float, speed: float) -> void:
	_direction = speed * direction.normalized()
	_life_span = life_span
	_life_time = _life_span

func _on_area_entered(area):
	queue_free()
