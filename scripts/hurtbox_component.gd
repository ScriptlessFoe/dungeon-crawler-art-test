extends Area2D
class_name HurtboxComponent
# basic hurtbox that recieves attacks
# requires a StatsComponent
# requires a CollisionShape2D

@export var statsComponent:StatsComponent
@export var hurtbox:CollisionShape2D

func _ready() -> void:
	# error check
	if not hurtbox:
		print("AttackComponent: missing hurtbox:CollisionShape2D")
		return

func attack_recieved(amount:int) -> void:
	statsComponent.take_damage(amount)
