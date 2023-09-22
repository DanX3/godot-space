class_name Enemy extends CharacterBody2D

signal died

const SPEED = 150.0

func _ready():
	get_tree().get_nodes_in_group("player")[0].enemy_spawned(self)

func _physics_process(delta):
	if get_tree().get_nodes_in_group("player").is_empty():
		return
	
	var player = get_tree().get_nodes_in_group("player")[0]
	look_at(player.global_position)
	var direction: Vector2 = player.global_position - global_position
	direction = direction.normalized()
	velocity = direction * SPEED
	if move_and_slide():
		var collision = get_last_slide_collision()
		if collision.get_collider().has_meta("player"):
			collision.get_collider().game_over()


