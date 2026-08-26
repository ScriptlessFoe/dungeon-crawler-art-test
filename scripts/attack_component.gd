extends Area2D
class_name AttackComponent
# basic attack with hitbox
# requires a StatsComponent
# requires a CollisionShape2D

@export var statsComponent:StatsComponent
@export var hitbox:CollisionShape2D

func _ready() -> void:
	# error check
	if not statsComponent:
		print("AttackComponent: missing StatsComponent")
		return
	if not hitbox:
		print("AttackComponent: missing hitbox:CollisionShape2D")
		return

func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		# avoid hitting self
		if area.owner == self.owner:
			return
		
		# signal attack
		area.attack_recieved(statsComponent.statsData.attack)
		print("AttackComponent: found hurtbox")
