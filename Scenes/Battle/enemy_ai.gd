extends Node2D

#Delay Between Ai Determining Whether to Spawn
@export var iteration_delay = 4.0
@export var min_amount = 1
@export var max_amount = 3

#RNG!!
var rng = RandomNumberGenerator.new()

#Lane Detection
var wizard_lane1 = false
var wizard_lane2 = false
var wizard_lane3 = false

signal spawn()



func _ready() -> void:
	$"Iteration Delay".paused = true
	$"Iteration Delay".wait_time = iteration_delay

func _process(delta: float) -> void:
	if (get_parent().get_parent().inBattle == true):
		$"Iteration Delay".paused = false
		
	# TODO checks how many enemies and troops in each lane


# 50/50 chance. Decides whether or not to spawn in enemies
func spawn_or_no_spawn() -> bool:
	if(rng.randi_range(0, 2) == 1):
		print("spawned")
		return true
	print("not spawned")
	return false


func decide_type():
	var type = rng.randi_range(0, 1)
	match type:
		0:
			return "sus"
		1:
			return "spike"
		2:
			return "liz3"
		3:
			return "liz4"
	print("No Unit")

# Randomizes number of troops spawned at once
func decide_amount():
	return rng.randi_range(min_amount, max_amount)

# Choose a lane based off of whether or not a lizard is already there
func decide_lane():
	return rng.randi_range(1, 3)


func send_spawn_signal(type, lane, amount) -> void:
	spawn.emit(type, lane, amount)


# Functions will use this to change iteration delay for difficulty purposes
func change_iteration_delay(delay: float):
	$"Iteration Delay".wait_time = delay


func _on_iteration_delay_timeout() -> void:
	if (spawn_or_no_spawn()):
		send_spawn_signal(decide_type(), decide_lane(), decide_amount())
		
func _on_battle_lane_traffic(isFriendly, lane, increment):
	print(isFriendly, lane, increment)
