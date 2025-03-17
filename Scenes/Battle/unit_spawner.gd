extends Node2D

@export var sus_scene: PackedScene
@export var spike_scene: PackedScene

var starting_enemies:int # How many enemies we start with
var current_enemies: int # How many enemies there are currently


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Manually connect "laneSelected" signal from Battle node to this(Unit Spawner) node
	var battle = get_node("/root/Game/Display Manager/Battle")
	battle.laneSelected.connect(spawn)
	
	
	# Initialize enemy counter
	starting_enemies = get_child_count() # Typically 0 for now
	current_enemies = get_child_count()




# This loop will function as an enemy AI. It will handle waves
func _process(delta: float) -> void:
	# Checks if there are any enemies left
	current_enemies = get_child_count()
	
	# If there aren't any enemies left, spawns more
	if(starting_enemies == current_enemies):
		print("spawned spike")
		enemy_spawn_prep($EnemySpawnPoint1, 2)
		enemy_spawn_prep($EnemySpawnPoint2, 2)
		enemy_spawn_prep($EnemySpawnPoint3, 2)




# Will randomize the type of enemy spawned
func enemy_spawn_prep(location, amount):
	var randomType = randi_range(0, 1)
	match randomType:
		0:
			spawn("spike_scene", location, amount)
		1:
			spawn("sus_scene", location, amount)





# General spawner called by enemy AI and battle script
func spawn(type:String, location, amount):
	
	
	if(type == "spike_scene" || type == "sus_scene"):
		# Loops through spawner "amount" times
		for i in amount:
			var unit = type.instantiate()
			unit.global_position = location.global_position
			add_child(unit)
			await get_tree().create_timer(1.0).timeout
	else:
		print("Spawned in " + type)
