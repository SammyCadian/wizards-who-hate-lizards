extends Node2D

# Lane entry variables
var topLaneEnter = false
var middleLaneEnter = false
var bottomLaneEnter = false

# Scene Variables
#@export var unit_spawner: PackedScene

# Signal definition to recieve when the player selects a lane
signal laneSelected


# Unit variables
@export var unitSelected = false
@export var unitName = "NO_UNIT" # Track the name of what is selected in the UI

# Camera Variables
var cursorPos = Vector2(0,0) # Track the cursor position

# Unit Placement
var selectedLane = "NO_LANE"


# Currently unused, but when the camera is properly implemented it should:
# Be clamped around textures to avoid going out of boundaries
# Follow the cursor and/or move a slider to go across the battlefield horizontally
# The battle should start at a level of zoom onto the battlefield
# The UI should "follow" the camera so it is always completely visible
var followSpeed : float = 2.0 # Camera follow Speed
var zoomLevel : float = 1.0  # Camera zoom

func _ready():
	pass

func _process(delta):
	# Get the cursor position
	cursorPos = get_global_mouse_position()
	
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
		if (topLaneEnter || middleLaneEnter || bottomLaneEnter):
			if Input.is_action_just_pressed("leftMB"):
				laneSelected.emit(unitName, selectedLane, 5)
				# This should call an exported unit spawner function with passed in information
				# Alternatively this could GRAB information from a unit spawner function to get the exact node and spawn it locally
				# The cursorPos is where the unit position should be set
				# unitName is updated from the button press, currently only the top left button grabs something
				# Line 10 in the battle_ui.gd script should be changed to whatever the name the unit spawner is expecting
				# unitSpawnerNode.placeUnit(unitName, cursorPos) # EXAMPLE CALL using the unit spawner node directly, it will have to be accessed before hand
				# Global.placeUnit(unitName, cursorPos) # EXAMPLE CALL using Global script as an easy route to unit spawner
				


func _on_battle_ui_unit_button_pressed(pressedUnitID: String) -> void:
	unitSelected = true
	unitName = pressedUnitID
