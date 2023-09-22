extends Node

var enemy_scene = preload("res://solution/scenes/enemy.tscn")
@export var player: CharacterBody2D
const SPAWN_DISTANCE = 750.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_timer_timeout():
	var enemy = enemy_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = player.global_position + SPAWN_DISTANCE * \
		Vector2.RIGHT.rotated(randf_range(0.0, 2.0 * PI))
