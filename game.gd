extends Node2D

var map : Node = null  # Store the map
var currScene : Node = null  # Track the active scene
var pauseInstance : Node = null # Track the current pause menu
@export var inMenu : bool = false # Flag to indicate if the user is in a menu
@export var paused : bool = false # Flag to indicate if the user is paused

func _ready():
	generateMap()
	loadStart()
	
func _process(delta):
	if (Input.is_action_just_pressed("Pause")):
		if (!paused && !inMenu):
			pauseGame()
		elif (paused):
			resumeGame()
	
	if ($BattleManager.inBattle):
		if (Input.is_action_pressed("cameraLeft") && $Camera2D.position.x != -50):
			$Camera2D.position.x -= 5
			
		if (Input.is_action_pressed("cameraRight")  && $Camera2D.position.x != 50):
			$Camera2D.position.x += 5

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
	pauseInstance = load("res://Scenes/UI/pause_menu.tscn").instantiate()
	$Camera2D.position = Vector2(0, 0)
	add_child(pauseInstance)
	zaWarudo(true)
	inMenu = true
	paused = true

func resumeGame():
	pauseInstance.queue_free()
	zaWarudo(false)
	inMenu = false
	paused = false

# Pause the battle manager node
func zaWarudo(isPaused : bool):
	if isPaused:
		print("Time is frozen!")
		$BattleManager.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		print("Time will now resume!")
		$BattleManager.process_mode = Node.PROCESS_MODE_INHERIT

func showWarBonds():
	$WarBonds.show()
	
func hideWarBonds():
	$WarBonds.hide()

func updateWarBonds():
	$WarBonds.text = "WAR BONDS: %s" % Global.PLAYER_WAR_BONDS
