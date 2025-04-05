extends Node2D

#Delay Between Ai Determining Whether to Spawn
@export var iteration_delay = 5.0
@export var min_amount = 1
@export var max_amount = 3

#RNG!!
var rng = RandomNumberGenerator.new()

#Lane Tracker
var wizard_lanes = {"TOP": 0,"MID": 0, "BOT": 0}
var lizard_lanes = {"TOP": 0,"MID": 0, "BOT": 0}

signal spawn(type, lane, amount)

func _ready() -> void:
	$"Iteration Delay".paused = true
	$"Iteration Delay".wait_time = iteration_delay

func _process(delta: float) -> void:
	if (get_parent().get_parent().inBattle == true):
		$"Iteration Delay".paused = false


# 66/33 chance in spawn favor. Decides whether or not to spawn in enemies
func spawn_or_no_spawn() -> bool:
	if(rng.randi_range(0, 2) == 2):
		# not spawned
		return false
	# spawned
	return true

# Randomizes type of troop spawned
func decide_type():
	var type = rng.randi_range(0, 1)
	match type:
		0:
			return "Sus"
		1:
			return "Spike"
		2:
			return "Liz3"
		3:
			return "Liz4"
	print("No Unit")

# Randomizes number of troops spawned at once
func decide_amount():
	return rng.randi_range(min_amount, max_amount)

# Choose a lane based off of whether or not a lizard is already there
func decide_lane():
	# TODO return the preferred lane with the following priotity:
	# 1. lanes without lizards 
	if 0 in lizard_lanes.values():
		return lizard_lanes.find_key(0)
	
	# 2. lanes with the most wizard
	var best_lane = "TOP"
	for lane in wizard_lanes:
		if wizard_lanes[lane] > wizard_lanes[best_lane]:
			best_lane = lane
	return best_lane


func send_spawn_signal(type, lane, amount) -> void:
	spawn.emit(type, lane, amount)


# Functions will use this to change iteration delay for difficulty purposes
func change_iteration_delay(delay: float):
	$"Iteration Delay".wait_time = delay


func _on_iteration_delay_timeout() -> void:
	if (spawn_or_no_spawn()):
		send_spawn_signal(decide_type(), decide_lane(), decide_amount())


# Recieves lane traffic signal from battle scene
func _on_battle_lane_traffic(isFriendly, lane, increment):
	if isFriendly:
		wizard_lanes[lane] += increment
	else:
		lizard_lanes[lane] += increment
