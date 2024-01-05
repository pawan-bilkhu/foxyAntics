extends EnemyBase


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player_detector = $PlayerDetector
@onready var move_timer = $MoveTimer
@onready var shooter = $Shooter

const FLY_VELOCITY: Vector2 = Vector2(35, 15)

var _fly_direction: Vector2 = Vector2.ZERO


func _ready():
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super._physics_process(delta)
	velocity = _fly_direction
	move_and_slide()
	shoot()


func shoot() -> void:
	if player_detector.is_colliding():
		shooter.shoot(global_position.direction_to(_player_reference.global_position))


func set_movement_direction() -> void:
	var x_direction = sign(_player_reference.global_position.x - global_position.x)
	if x_direction > 0:
		animated_sprite_2d.flip_h = true
		_facing = FACING.RIGHT
	else:
		animated_sprite_2d.flip_h = false
		_facing = FACING.LEFT
	_fly_direction = Vector2(FLY_VELOCITY.x * _facing, FLY_VELOCITY.y)


func fly_towards_player() -> void:
	set_movement_direction()
	move_timer.start()
	
func _on_visible_on_screen_notifier_2d_screen_entered():
	animated_sprite_2d.play("fly")
	fly_towards_player()


func _on_move_timer_timeout():
	fly_towards_player()
