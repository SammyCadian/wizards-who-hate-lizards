extends Node2D

# Lane entry variables
var topLaneEnter = false
var middleLaneEnter = false
var bottomLaneEnter = false

# Scene Variables
#@export var unit_spawner: PackedScene

# Signal definition to recieve when the player selects a lane
signal laneSelected(unitName, selectedLane, unitNum)
signal spendPoints(cost: int)
signal winCon(side)

# Unit variables
@export var unitSelected = false
@export var unitName = "NO_UNIT" # Track the name of what is selected in the UI
var unitCost = 0

# Camera Variables
var cursorPos = Vector2(0,0) # Track the cursor position

# Unit Placement
var selectedLane = "NO_LANE"

func _ready():
	pass

func _process(delta):
	
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
				laneSelected.emit(unitName, selectedLane, 1)
			unitSelected = false
			unitName = "NO_UNIT"
			var unitCost = 0


func _on_battle_ui_unit_button_pressed(pressedUnitID: String, cost: int) -> void:
	unitSelected = true
	unitName = pressedUnitID
	unitCost = cost


func _on_lizard_win_con_area_entered(area: Area2D) -> void:
	winCon.emit("Lizards")


func _on_wizard_win_con_area_entered(area: Area2D) -> void:
	winCon.emit("Wizards")
