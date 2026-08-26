extends Node
class_name MovementComponent2D
# basic 2d movement controller
# requires a StatsComponent

@export var statsComponent:StatsComponent

@export var acceleration: float = 15000.0
@export var friction: float = 2000.0

func _ready() -> void:
	# error check
	if not statsComponent:
		print("MovementComponent: missing StatsComponent")
		return

# basic movement
func handle_movement(body: CharacterBody2D, direction: Vector2, delta: float) -> void:
	# grab speed stat
	var maxSpeed:float = statsComponent.statsData.maxSpeed * statsComponent.speedMultiplier if statsComponent else 300.0
	
	if direction != Vector2.ZERO:
		# accelerate to max speed
		body.velocity = body.velocity.move_toward(direction * maxSpeed, acceleration * delta)
	else:
		# friction to stop
		body.velocity = body.velocity.move_toward(Vector2.ZERO, friction * delta)
