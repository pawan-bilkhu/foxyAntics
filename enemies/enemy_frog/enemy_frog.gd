extends EnemyBase


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var jump_timer = $JumpTimer

const JUMP_VELOCITY: Vector2 = Vector2(100, -150)
const JUMP_WAIT_DURATION: Vector2 = Vector2(2.5, 5.0)

var _can_jump: bool = false
var _detected_by_player: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	start_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super._physics_process(delta)
	
	if not is_on_floor():
		velocity.y += _gravity * delta
	else:
		velocity.x = 0
		animated_sprite_2d.play("idle")
		
	perform_jump()
	move_and_slide()
	flip_facing_direction()

func perform_jump() -> void:
	if not is_on_floor():
		return
	
	if not _detected_by_player or not _can_jump:
		return
	
	velocity = JUMP_VELOCITY
	velocity.x *= _facing
	
	_can_jump = false
	
	animated_sprite_2d.play("jump")
	start_timer()


func flip_facing_direction() -> void: 
	if ( _player_reference.global_position.x > global_position.x 
		and not animated_sprite_2d.flip_h ):
		animated_sprite_2d.flip_h = true
		_facing = FACING.RIGHT
	elif ( _player_reference.global_position.x < global_position.x 
		and animated_sprite_2d.flip_h ):
		animated_sprite_2d.flip_h = false
		_facing = FACING.LEFT


func start_timer() -> void:
	jump_timer.wait_time = randf_range(JUMP_WAIT_DURATION.x, JUMP_WAIT_DURATION.y)
	jump_timer.start()


func _on_jump_timer_timeout():
	_can_jump = true


func _on_visible_on_screen_notifier_2d_screen_entered():
	# print("Detected by player")
	_detected_by_player = true
	start_timer()

