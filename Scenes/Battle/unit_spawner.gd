extends Node2D

@export var sus_scene: PackedScene
@export var spike_scene: PackedScene

var starting_enemies:int # How many enemies we start with
var current_enemies: int # How many enemies there are currently

var start_wave: int
var current_wave: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initializes wave counters, doesnt actually do anything yet
	start_wave = 0
	current_wave = start_wave
	
	starting_enemies = get_child_count() # Typically 0 for now
	current_enemies = get_child_count()


# This loop will function as an enemy AI. It will handle waves
func _process(delta: float) -> void:
	current_enemies = get_child_count()
	if(starting_enemies == current_enemies):
		current_wave += 1
		# New wave animation/notification
		print(current_wave)
		enemy_spawn("spike", 1.5)
		
		

# This function takes in the base spawns for that mob type, and will later be
# modular as to increase spawns based on the level in the overwold and/or
# the current wave
func enemy_spawn(type, base_amount):
	# Delay per spawn
	var mob_spawn_delay: float = 2.0 
	
	# Calculates how many rounds to spawn based on current wave
	var mob_rounds = base_amount*current_wave
	if type == "spike":
		var lane_1 = $EnemySpawnPoint1
		var lane_2 = $EnemySpawnPoint2
		var lane_3 = $EnemySpawnPoint3
		if mob_rounds>=1:
			for i in mob_rounds:
				var spike1 = spike_scene.instantiate()
				spike1.global_position = lane_1.global_position
				var spike2 = spike_scene.instantiate()
				spike2.global_position = lane_2.global_position
				var spike3 = spike_scene.instantiate()
				spike3.global_position = lane_3.global_position
				
				add_child(spike1)
				await get_tree().create_timer(mob_spawn_delay).timeout
				add_child(spike2)
				await get_tree().create_timer(mob_spawn_delay).timeout
				add_child(spike3)
				await get_tree().create_timer(mob_spawn_delay).timeout
				
