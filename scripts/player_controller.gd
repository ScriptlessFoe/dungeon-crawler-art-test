extends CharacterBody2D
class_name Player

@onready var movementComponent:MovementComponent2D = %MovementComponent2D
@onready var pivot:Node2D = %FlipPivot
@onready var animationPlayer:AnimationPlayer = %AnimationPlayer
@onready var statsComponent:StatsComponent = %StatsComponent

@export var pushForce:float = 10.0

var is_attacking:bool = false

func _ready() -> void:
		# set up signals
	statsComponent.healthChanged.connect(_on_health_changed)
	statsComponent.healthDepleted.connect(_on_health_depleted)

func _physics_process(delta: float) -> void:
	# use inputs to get direction
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# handle velocity control
	movementComponent.handle_movement(self, direction, delta)
	
	# character facing direction
	if (direction.x > 0):
		pivot.scale.x = 1.0
	elif (direction.x < 0):
		pivot.scale.x = -1.0
	
	# actually execute the movement and process collisions
	move_and_slide()
	
	# check for RigidBody2D collisions and apply force
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		var collider = collision.get_collider()
		
		if collider is RigidBody2D:
			var pushDir:Vector2 = -collision.get_normal() # get opposite of normal to push away
			collider.apply_impulse(pushDir * pushForce * velocity.length() * delta) 

func _unhandled_input(event: InputEvent) -> void:
	# handle attacks with animation player
	if event.is_action_pressed("attack") and not is_attacking:
		is_attacking = true
		animationPlayer.play("attack") # play attack animation to deal with hitbox - should move this to a "weapon" class in the future
		
		await animationPlayer.animation_finished
		is_attacking = false

func _on_health_changed(currentHP:int, maxHP:int) -> void:
	print("Player health: ", currentHP, "/", maxHP)

func _on_health_depleted() -> void:
	print("Player died")
