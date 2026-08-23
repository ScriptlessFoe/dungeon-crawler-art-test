extends CharacterBody2D
class_name Player

@onready var movementComponent:MovementComponent2D = %MovementComponent2D
@onready var pivot:Node2D = %FlipPivot

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# use built-in inputs to get direction
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# handle velocity control
	movementComponent.handle_movement(self, direction, delta)
	
	# character facing direction
	if (direction.x > 0):
		pivot.scale.x = -1.0
	elif (direction.x < 0):
		pivot.scale.x = 1.0
	
	# Actually execute the movement and process collisions
	move_and_slide()
