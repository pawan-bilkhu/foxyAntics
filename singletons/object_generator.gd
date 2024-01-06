extends Node

enum BULLET_KEY { PLAYER, ENEMY }
enum SCENE_KEY { EXPLOSION, FRUIT_PICK_UP}

const BULLETS = {
	BULLET_KEY.PLAYER: preload("res://bullet/bullet_player/bullet_player.tscn"),
	BULLET_KEY.ENEMY: preload("res://bullet/bullet_enemy/bullet_enemy.tscn")
}
const SIMPLE_SCENES = {
	SCENE_KEY.EXPLOSION: preload("res://explosion/explosion.tscn"),
	SCENE_KEY.FRUIT_PICK_UP: preload("res://fruit_pick_up/fruit_pick_up.tscn")
}



func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)


func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)


func create_bullet(direction: Vector2, life_span: float, speed: float, start_position: Vector2, key: BULLET_KEY) -> void:
	var new_bullet = BULLETS[key].instantiate()
	new_bullet.initialize_bullet(direction, life_span, speed)
	new_bullet.global_position = start_position
	call_add_child(new_bullet)

func create_simple_scene(start_position: Vector2, key: SCENE_KEY) -> void:
	var new_explosion = SIMPLE_SCENES[key].instantiate()
	new_explosion.global_position = start_position
	call_add_child(new_explosion)


