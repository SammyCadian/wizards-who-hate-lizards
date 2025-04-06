extends Node2D

# Lane entry variables
var topLaneEnter = false
var middleLaneEnter = false
var bottomLaneEnter = false

# Scene Variables
@export var bossEnemy: PackedScene

# Signal definition to recieve when the player selects a lane
signal laneSelected(unitName, selectedLane, unitNum)
signal spendPoints(cost: int)
signal winCon(side)

# Signal definition for units entering and leaving a lane
signal laneTraffic(isFriendly, lane, increment)

@export var missileAbility: PackedScene
@export var shotgunAbility: PackedScene
@export var antideathAbility: PackedScene
@export var flamerainAbility: PackedScene
# Unit variables
@export var unitSelected = false
@export var unitName = "NO_UNIT" # Track the name of what is selected in the UI
var unitCost = 0
var unitOrAbility = 0
var isFriendly = true

var defenseTimer = 10.0

# Camera Variables
var cursorPos = Vector2(0,0) # Track the cursor position

# Unit Placement
var selectedLane = "NO_LANE"

func activateTrapCard(abilityID: String, mousePos: Vector2):
	print(mousePos)
	match abilityID:
		"Missile Launch":
			var newAbility = missileAbility.instantiate()
			newAbility.setTarget(mousePos)
			add_child(newAbility)
		"Shotgun":
			var newAbility = shotgunAbility.instantiate()
			newAbility.setTarget(mousePos)
			add_child(newAbility)
		"Anti-Dying Circle":
			var newAbility = antideathAbility.instantiate()
			newAbility.setTarget(mousePos)
			add_child(newAbility)
		"Flame Rain":
			var newAbility = flamerainAbility.instantiate()
			newAbility.setTarget(mousePos)
			add_child(newAbility)

func _ready():
	pass

func _process(delta):
	defenseTimer -= delta
	$TimerLabel.text = "Hold out for %10.2f" % defenseTimer
	
	# Refresh lane var
	selectedLane = "NO_LANE"
	
	# Lane entry is checked every frame
	if ($topLane.laneEntered):
		selectedLane = "TOP_LANE"
	elif ($middleLane.laneEntered):
		selectedLane = "MID_LANE"
	elif ($bottomLane.laneEntered):
		selectedLane = "BOT_LANE"
	
	# Place a unit if one is selected
	if unitSelected:
		if Input.is_action_just_pressed("leftMB"):
			if (selectedLane != "NO_LANE"):
				spendPoints.emit(unitCost)
				if unitOrAbility == 1:
					laneSelected.emit(unitName, selectedLane, 1)
				else:
					Global.boughtItems[unitName] = Global.boughtItems.get(unitName) - 1
					activateTrapCard(unitName, get_global_mouse_position())
					
			unitSelected = false
			unitName = "NO_UNIT"
			unitCost = 0


func _on_battle_ui_unit_button_pressed(pressedUnitID: String, cost: int) -> void:
	unitSelected = true
	unitName = pressedUnitID
	unitCost = cost
	unitOrAbility = 1

func _on_battle_ui_ability_button_pressed(pressedAbilityID: String, cost: int) -> void:
	unitSelected = true
	unitName = pressedAbilityID
	unitCost = cost
	unitOrAbility = 2
	pass # Replace with function body.

func _on_lizard_win_con_area_entered(area: Area2D) -> void:
	winCon.emit("Lizards")


func WizardWinCon():
	winCon.emit("Wizards")
	




## For enemy ai scene: Tracks what units are in each lane

# Sends signal to enemy ai
func send_laneTraffic_signal(isFriendly, lane, increment):
	laneTraffic.emit(isFriendly, lane, increment)

# Tracks each lane's entries and exits (top middle and bottom)
func _on_top_lane_body_entered(body: Node2D) -> void:
	send_laneTraffic_signal(body.is_friendly, "TOP", 1)

func _on_top_lane_body_exited(body: Node2D) -> void:
	send_laneTraffic_signal(body.is_friendly, "TOP", -1)

func _on_middle_lane_body_entered(body: Node2D) -> void:
	send_laneTraffic_signal(body.is_friendly, "MID", 1)

func _on_middle_lane_body_exited(body: Node2D) -> void:
	send_laneTraffic_signal(body.is_friendly, "MID", -1)

func _on_bottom_lane_body_entered(body: Node2D) -> void:
	send_laneTraffic_signal(body.is_friendly, "BOT", 1)

func _on_bottom_lane_body_exited(body: Node2D) -> void:
	send_laneTraffic_signal(body.is_friendly, "BOT", -1)


func _on_defense_timer_timeout() -> void:
	$DefenseTimer.stop()
	var newBoss = bossEnemy.instantiate()
	newBoss.connect("death", WizardWinCon)
	newBoss.position += Vector2(600, 90)
	add_child(newBoss)
	pass # Replace with function body.
