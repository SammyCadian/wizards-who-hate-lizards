extends Node2D

var currScene : Node = null  # Track the active scene

func _ready():
	loadStart()

# Clear the current scene
func clearScene():
	if currScene:
		currScene.queue_free()

# Switch and load scenes
# Returns the newly loaded scene if caller needs it (as seen in Battle Manager)
func loadScene(path : String) -> Node2D:
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
	$Map.show()
	$Map.enableButtons()

func unloadMap():
	$Map.hide()
	$Map.disableButtons()
