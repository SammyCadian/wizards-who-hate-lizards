extends Node2D

@export var sus_scene: PackedScene
@export var spike_scene: PackedScene
@export var ghost_scene: PackedScene
@export var scout_scene: PackedScene
@export var rifleman_scene: PackedScene
@export var autorifle_scene: PackedScene
@export var sniper_scene: PackedScene
@export var hoplite_scene: PackedScene
@export var caster_scene: PackedScene

var starting_enemies:int # How many enemies we start with
var current_enemies: int # How many enemies there are currently

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	starting_enemies = get_child_count() # Typically 0 for now
	current_enemies = get_child_count()

# This loop will function as an enemy AI. It will handle waves
func _process(delta: float) -> void:
	pass
	## Checks how many enemies there are left
	#current_enemies = get_child_count()
	#if(starting_enemies == current_enemies):
		#enemy_spawn_prep($EnemySpawnPoint1, 0)
		#enemy_spawn_prep($EnemySpawnPoint2, 3)
		#enemy_spawn_prep($EnemySpawnPoint3, 0)

# General spawner called by enemy AI and battle script
func spawn(type, location, amount):
	# Spawn units if a battle is happening
	if get_parent().inBattle:
		for i in amount:
			var unit = type.instantiate()
			var randPrecent = RandomNumberGenerator.new().randf()
			unit.position = location.position + Vector2(0, -30 * randPrecent)
			get_parent().currBattle.add_child(unit) # Add units as children to the battle scene
			await get_tree().create_timer(1.0).timeout

func getSpawnPoint(laneID):
	match (laneID):
		"TOP_LANE":
			return $WizSpawnPoint1
		"MID_LANE":
			return $WizSpawnPoint2
		"BOT_LANE":
			return $WizSpawnPoint3
		"TOP":
			return $EnemySpawnPoint1
		"MID":
			return $EnemySpawnPoint2
		"BOT":
			return $EnemySpawnPoint3

func getUnit(unitID: String):
	match (unitID):
		"Scout":
			return scout_scene
		"Rifleman":
			return rifleman_scene
		"Autorifle":
			return autorifle_scene
		"Sniper":
			return sniper_scene
		"Hoplite":
			return hoplite_scene
		"Caster":
			return caster_scene
		"Sus":
			return sus_scene
		"Spike":
			return spike_scene
		"Ghost":
			return ghost_scene
		

func _on_battle_lane_selected(unitName: String, selectedLane: String, unitNum: int) -> void:
	spawn(getUnit(unitName), getSpawnPoint(selectedLane), unitNum)

func _on_enemy_ai_spawn(unitName, selectedLane, unitNum) -> void:
	if (get_parent().inBattle):
		spawn(getUnit(unitName), getSpawnPoint(selectedLane), unitNum)
