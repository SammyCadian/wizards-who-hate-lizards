extends Node2D

var map : Node = null  # Store the map
var currScene : Node = null  # Track the active scene
@export var inMenu : bool = false # Flag to indicate if the user is in a menu

func _ready():
	generateMap()
	loadStart()
	
func _process(delta):
	if (!inMenu  && Input.is_action_just_pressed("Escape")):
		pauseGame()

func generateMap():
	map = load("res://Scenes/UI/map.tscn").instantiate()
	add_child(map)

# Clear the current scene
func clearScene():
	inMenu = false
	if currScene != null:
		currScene.queue_free()

# Switch and load scenes
# Returns the newly loaded scene if caller needs it (as seen in Battle Manager)
func loadScene(path : String) -> Node:
	# Clear old scene and hide the map
	clearScene()
	unloadMap()

	# Add the new loaded scene to the game tree
	var newScene = load(path).instantiate()
	add_child(newScene)
	currScene = newScene
	
	return newScene

# Load the start menu, keeping the map unloaded
func loadStart():
	unloadMap()
	loadScene("res://Scenes/UI/start_menu.tscn")
	inMenu = true

func loadMap():
	clearScene()
	updateWarBonds()
	showWarBonds()
	map.show()

func unloadMap():
	hideWarBonds()
	map.hide()

func restartGame():
	# Free the old map and make a new one
	map.queue_free()
	generateMap()
	
	# Go back to the start menu
	loadStart()
	
func pauseGame():
	var pauseInstance = load("res://Scenes/UI/pause_menu.tscn").instantiate()
	add_child(pauseInstance)
	inMenu = true

# Pause all node trees
func zaWarudo(isPaused : bool):
	if isPaused:
		print("Time is frozen!")
		$BattleManager.process_mode = Node.PROCESS_MODE_DISABLED
		get_node("Map").process_mode = Node.PROCESS_MODE_DISABLED
	else:
		print("Time will now resume!")
		$BattleManager.process_mode = Node.PROCESS_MODE_INHERIT
		get_node("Map").process_mode = Node.PROCESS_MODE_INHERIT

func showWarBonds():
	$WarBonds.show()
	
func hideWarBonds():
	$WarBonds.hide()

func updateWarBonds():
	$WarBonds.text = "WAR BONDS: %s" % Global.PLAYER_WAR_BONDS
