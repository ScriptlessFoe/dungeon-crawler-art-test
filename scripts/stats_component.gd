extends Node
class_name StatsComponent
# basic stats controller
# requires CharacterStatsData resource

@export var statsData:CharacterStatsData

# dynamic stats
@onready var currentHealth:int = statsData.maxHealth if statsData else 100
var speedMultiplier:float = 1.0

signal healthChanged(currentHP:int, maxHP:int)
signal healthDepleted

func _ready() -> void:
	# error check
	if not statsData:
		print("StatsComponent: missing CharacterStatsData")
		return

func take_damage(amount: int) -> void:
	if statsData == null: return
	
	# make sure health is bounded
	currentHealth = clamp(currentHealth - amount, 0, statsData.maxHealth)
	
	# signal
	healthChanged.emit(currentHealth, statsData.maxHealth)
	if currentHealth <= 0:
		healthDepleted.emit()

func heal(amount: int) -> void:
	if statsData == null: return
	
	# make sure health is bounded
	currentHealth = clamp(currentHealth + amount, 0, statsData.maxHealth)
	
	# signal
	healthChanged.emit(currentHealth, statsData.maxHealth)
