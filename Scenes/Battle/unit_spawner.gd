extends Node2D

@export var sus_scene: PackedScene
@export var spike_scene: PackedScene
@export var scout_scene: PackedScene
@export var rifleman_scene: PackedScene
@export var autorifle_scene: PackedScene

var starting_enemies:int # How many enemies we start with
var current_enemies: int # How many enemies there are currently

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	starting_enemies = get_child_count() # Typically 0 for now
	current_enemies = get_child_count()

# This loop will function as an enemy AI. It will handle waves
func _process(delta: float) -> void:
	# Checks how many enemies there are left
	current_enemies = get_child_count()
	
	# If there aren't any enemies left, spawns more
	if(starting_enemies == current_enemies):
		enemy_spawn_prep($EnemySpawnPoint1, 0)
		enemy_spawn_prep($EnemySpawnPoint2, 3)
		enemy_spawn_prep($EnemySpawnPoint3, 0)
		pass

# Will randomize the type of enemy spawned
func enemy_spawn_prep(location, amount):
	var randomType = randi_range(0, 1)
	match randomType:
		0:
			spawn(sus_scene, location, amount)
		1:
			spawn(spike_scene, location, amount)

# General spawner called by enemy AI and battle script
func spawn(type, location, amount):
	for i in amount:
		var unit = type.instantiate()
		unit.position = location.position
		add_child(unit)
		await get_tree().create_timer(1.0).timeout

func getSpawnPoint(laneID: String):
	match (laneID):
		"TOP_LANE":
			return $WizSpawnPoint1
		"MID_LANE":
			return $WizSpawnPoint2
		"BOT_LANE":
			return $WizSpawnPoint3

func getUnit(unitID: String):
	match (unitID):
		"scout":
			return scout_scene
		"rifleman":
			return rifleman_scene
		"autorifle":
			return autorifle_scene

func _on_battle_lane_selected(unitName: String, selectedLane: String, unitNum: int) -> void:
	print(unitName)
	spawn(getUnit(unitName), getSpawnPoint(selectedLane), unitNum)
