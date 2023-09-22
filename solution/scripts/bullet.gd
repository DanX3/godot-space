extends CharacterBody2D

var explosion_scene = preload("res://solution/scenes/explosion.tscn")
const SPEED = 1000.0
var direction: Vector2

func set_dir(dir: Vector2):
	direction = dir
	velocity = SPEED * dir

func _physics_process(delta):
	velocity = SPEED * direction
	move_and_slide()
	
	var collision = get_last_slide_collision()
	if collision:
		if collision.get_collider() is Enemy:
			var enemy = collision.get_collider() as Enemy
			_spawn_collision_at(enemy.global_position)
			enemy.emit_signal("died")
			enemy.queue_free()
			queue_free()


func _spawn_collision_at(pos: Vector2):
	print("spawned explosion")
	var explosion = explosion_scene.instantiate()
	explosion.global_position = pos
	get_tree().root.add_child(explosion)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
