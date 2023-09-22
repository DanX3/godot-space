class_name DestroyAfter extends Node

@export var timeToDestruction := 1.0

func _process(delta):
	timeToDestruction -= delta
	if timeToDestruction < 0.0:
		get_parent().queue_free()
