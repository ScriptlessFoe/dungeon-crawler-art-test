extends Node
class_name MovementComponent

var actor:CharacterBody2D

func _ready() -> void:
	if get_parent() is CharacterBody2D:
		actor = get_parent()

func handle_movement() -> void:
	pass
	# add movement here for velocity, acceleration, and deccelerations
