extends CharacterBody2D
class_name Enemy

@onready var movementComponent:MovementComponent2D = %MovementComponent2D
@onready var pivot:Node2D = %FlipPivot
@onready var animationPlayer:AnimationPlayer = %AnimationPlayer
@onready var statsComponent:StatsComponent = %StatsComponent

@export var attackDelay:float = 3.0
var attackDeltaAccumulator:float = 0.0

var isAttacking:bool = false


func _ready() -> void:
	# set up signals
	statsComponent.healthChanged.connect(_on_health_changed)
	statsComponent.healthDepleted.connect(_on_health_depleted)

func _physics_process(delta: float) -> void:
	# handle movement
	move(delta)
	
	# handle attacks
	
	if attackDeltaAccumulator > attackDelay:
		attack()
		attackDeltaAccumulator = 0.0
	else:
		attackDeltaAccumulator += delta

func move(delta: float) -> void:
	var direction:Vector2 = Vector2(0,0) # no movement yet
	
	# handle velocity control
	movementComponent.handle_movement(self, direction, delta)
	
	# character facing direction
	if (direction.x > 0):
		pivot.scale.x = 1.0
	elif (direction.x < 0):
		pivot.scale.x = -1.0
	
	# Actually execute the movement and process collisions
	move_and_slide()

func attack() -> void:
	isAttacking = true
	animationPlayer.play("attack")
	print("attacking")
	await animationPlayer.animation_finished
	isAttacking = false

func _on_health_changed(currentHP:int, maxHP:int) -> void:
	print("Enemy health: ", currentHP, "/", maxHP)

func _on_health_depleted() -> void:
	print("Enemy died")
