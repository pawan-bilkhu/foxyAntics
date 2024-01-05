extends Node2D


@onready var sound_player = $SoundPlayer
@onready var shoot_timer = $ShootTimer


@export var speed: float = 50.0
@export var life_span: float = 10.0
@export var bullet_key: ObjectGenerator.BULLET_KEY
@export var shoot_interval: float = 0.7

var can_shoot: bool = true

func _ready():
	shoot_timer.wait_time = shoot_interval

func shoot(direction: Vector2) -> void:
	if not can_shoot:
		return
	
	can_shoot = false
	SoundManager.play_clip(sound_player, SoundManager.SOUND_LASER)
	# create_bullet(direction: Vector2, life_span: float, speed: float, start_position: Vector2, key: BULLET_KEY)
	ObjectGenerator.create_bullet(direction, life_span, speed, global_position, bullet_key)
	shoot_timer.start()

func _on_shoot_timer_timeout():
	can_shoot = true
