extends Node2D

@export var tutorialOverlay: PackedScene
@export var finalOverlay: PackedScene
@export var inBattle = false
@export var currBattle : Node = null  # Track the current battle
var battleUI : Node = null  # Track the current battle UI
@onready var camera : Camera2D = get_parent().get_node("Camera2D")

# Preload nodes for instantation
var victoryScene = preload("res://Scenes/UI/victory_ui.tscn")
var gameOverScene = preload("res://Scenes/UI/game_over.tscn")
var victoryInstance

# Start the battle from the map selection
func startBattle(loadedUnits: Array, location: String):
	if location != "???":
		currBattle = get_parent().loadScene("res://Scenes/Battle/battle.tscn") # Load the battle into the game
	else:
		currBattle = get_parent().loadScene("res://Scenes/Battle/finalbattle.tscn") # Load the battle into the game
	battleUI = currBattle.get_node("BattleUI") # Update the battle UI
	currBattle.laneSelected.connect($"Unit Spawner"._on_battle_lane_selected) # Connect the unit spawning signal
	currBattle.laneTraffic.connect($"Unit Spawner"/"Enemy AI"._on_battle_lane_traffic) # Connect the unit tracker signal
	currBattle.winCon.connect(_on_battle_win_con) # Connect the battle win/lose signal
	currBattle.get_node("Background").animation = location.to_lower() # Set the battle background
	battleCamera(true) # Turn on the battle camera
	currBattle.reparent(self)
	inBattle = true
	
	for i in range(4):
		if (loadedUnits[i][1] != "NO_UNIT"):
			battleUI.receiveUnit(loadedUnits[i][0], loadedUnits[i][1], loadedUnits[i][2])
			
	for i in range(2):
		if (loadedUnits[4+i][1] != "NO_ABILITY"):
			print(loadedUnits[i+4])
			battleUI.receiveAbility(loadedUnits[i+4][0], loadedUnits[i+4][1], loadedUnits[i+4][2])
	
	if location == "Barn":
		var tut = tutorialOverlay.instantiate()
		tut.connect("endTutorial", get_parent().undoPause)
		get_parent().add_child(tut)
		get_parent().zaWarudo(true)
	if location == "???":
		var finalExposition = finalOverlay.instantiate()
		finalExposition.connect("endTutorial", get_parent().undoPause)
		get_parent().add_child(finalExposition)
		get_parent().zaWarudo(true)

# Adjust the camera's zoom for battle
func battleCamera(isOn : bool):
	if isOn:
		camera.set_zoom(Vector2(0.86, 0.86))
	else:
		camera.position = Vector2(0, 0)
		camera.set_zoom(Vector2(0.6, 0.6))

func _on_battle_win_con(side: Variant) -> void:
	if inBattle:
		inBattle = false
		if (side == "Wizards"):
			print("we won!!!")
			playerWins()
		else:
			print("we lost...")
			lizardsWin()
			

func playerWins():
	# Reset the camera position
	camera.position = Vector2(0, 0)
	
	# Update player variables
	Global.ADD_WAR_BONDS(100)
	get_parent().updateWarBonds()
	Global.BATTLES_WON += 1
	Global.NODES_COMPLETED += 1
	
	# Track the progress on the map
	get_parent().get_node("Map").progressMap()
	
	# Instantiate the Victory UI
	victoryInstance = victoryScene.instantiate()
	victoryInstance.position = Vector2(0, 0) # Set the position
	victoryInstance.get_node("Button").pressed.connect(_victory_button) # Connect the pressed signal
	victoryInstance.get_node("HealthUpgrade").pressed.connect(selectHealthUpgrade)
	victoryInstance.get_node("DamageUpgrade").pressed.connect(selectDamageUpgrade)
	currBattle.add_child(victoryInstance)
	
func lizardsWin():
	# Reset the camera position
	camera.position = Vector2(0, 0)	

	# Reset player variables
	Global.resetPlayer()
	
	# Instantiate the Game Over UI
	var gameOverInstance = gameOverScene.instantiate()
	gameOverInstance.position = Vector2(0, 0) # Set the position
	gameOverInstance.get_node("Button").pressed.connect(_game_over_button) # Connect the pressed signal
	currBattle.add_child(gameOverInstance)

var selected = ""

func _victory_button():
	if selected == "HealthUpgrade":
		Global.setHealthUpgrade(.2)
	elif selected == "DamageUpgrade":
		Global.setDamageUpgrade(.2)
	if selected == "":
		victoryInstance.nuhUhProtocol()
		print("Please select an upgrade")
	else:
		selected = ""
		battleCamera(false) # Turn off the battle camera
		get_parent().get_node("Map").unlockUnit()
		get_parent().loadMap()
		
	
func _game_over_button():
	battleCamera(false) # Turn off the battle camera
	get_parent().restartGame()

func selectHealthUpgrade():
	selected = "HealthUpgrade"

func selectDamageUpgrade():
	selected = "DamageUpgrade"
	
