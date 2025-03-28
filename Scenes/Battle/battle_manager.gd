extends Node2D

@export var currBattle : Node = null  # Track the current battle
var battleUI : Node = null  # Track the current battle UI
@export var inBattle = false

# Preload nodes for instantation
var victoryScene = preload("res://Scenes/UI/victory_ui.tscn")
var gameOverScene = preload("res://Scenes/UI/game_over.tscn")

# Start the battle from the map selection
func startBattle(loadedUnits: Array):
	currBattle = get_parent().loadScene("res://Scenes/Battle/battle.tscn") # Load the battle into the game
	battleUI = currBattle.get_node("BattleUI") # Update the battle UI
	currBattle.laneSelected.connect($"Unit Spawner"._on_battle_lane_selected) # Connect the unit spawning signal
	currBattle.winCon.connect(_on_battle_win_con) # Connect the battle win/lose signal
	inBattle = true
	
	for i in range(4):
		if (loadedUnits[i][1] != "NO_UNIT"):
			battleUI.receiveUnit(loadedUnits[i][0], loadedUnits[i][1], loadedUnits[i][2])
			
	for i in range(2):
		if (loadedUnits[4+i][1] != "NO_ABILITY"):
			print(loadedUnits[i+4])
			battleUI.receiveAbility(loadedUnits[i+4][0], loadedUnits[i+4][1], loadedUnits[i+4][2])

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
	# Update player variables
	Global.ADD_WAR_BONDS(100)
	get_parent().get_node("Map").get_node("WarBonds").text = "WAR BONDS: %s" % Global.PLAYER_WAR_BONDS
	Global.BATTLES_WON += 1
	Global.NODES_COMPLETED += 1
	
	# Instantiate the Victory UI
	var victoryInstance = victoryScene.instantiate()
	victoryInstance.position = Vector2(0, 0) # Set the position
	victoryInstance.get_node("Button").pressed.connect(_victory_button) # Connect the pressed signal
	currBattle.add_child(victoryInstance)
	
func lizardsWin():
	# Reset player variables
	Global.PLAYER_WAR_BONDS = 0
	Global.BATTLES_WON = 0
	Global.NODES_COMPLETED = 0
	
	# Instantiate the Game Over UI
	var gameOverInstance = gameOverScene.instantiate()
	gameOverInstance.position = Vector2(0, 0) # Set the position
	gameOverInstance.get_node("Button").pressed.connect(_game_over_button) # Connect the pressed signal
	currBattle.add_child(gameOverInstance)

func _victory_button():
	get_parent().loadMap()
	
func _game_over_button():
	get_parent().restartGame()
