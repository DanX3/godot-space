extends CharacterBody2D


const SHOOT_DISTANCE = 35.0
var alive = true
var bullet_scene = preload("res://solution/scenes/bullet.tscn")
var start_time;
var enemy_killed := 0

func _ready():
	start_time = Time.get_ticks_msec()
	set_meta("player", true)
	

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		var dir = (get_global_mouse_position() - global_position).normalized()
		var spawn_point = SHOOT_DISTANCE * dir
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.set_dir(dir)
		bullet.global_position = global_position + spawn_point

func _physics_process(delta):
	if alive:
		$CanvasLayer/Label.text = "%.2f s" % ((Time.get_ticks_msec() - start_time) * 0.001)
	if not alive:
		return
		
	var dir = (get_global_mouse_position() - global_position).normalized()
	rotation = atan2(dir.y, dir.x) + 0.5 * PI

func game_over():
	alive = false
	$ShipL.hide()
	$CollisionShape2D.disabled = true
	$CanvasLayer/GameOver.show()

func enemy_spawned(enemy: Enemy):
	enemy.connect("died", _on_enemy_died)

func _on_enemy_died():
	enemy_killed += 1
	$CanvasLayer/EnemyKilled.text = str(enemy_killed)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://solution/scenes/game.tscn")
