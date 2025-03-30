extends Node2D

var map : Node = null  # Store the map
var currScene : Node = null  # Track the active scene

func _ready():
	generateMap()
	loadStart()

func generateMap():
	map = load("res://Scenes/UI/map.tscn").instantiate()
	add_child(map)

# Clear the current scene
func clearScene():
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

func showWarBonds():
	$WarBonds.show()
	
func hideWarBonds():
	$WarBonds.hide()

func updateWarBonds():
	$WarBonds.text = "WAR BONDS: %s" % Global.PLAYER_WAR_BONDS
