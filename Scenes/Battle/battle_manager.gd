extends Node2D

var currBattle : Node = null  # Track the current battle
var battleUI : Node = null  # Track the current battle UI
@export var inBattle = false


# Start the battle from the map selection
func startBattle(loadedUnits: Array):
	currBattle = get_parent().loadScene("res://Scenes/Battle/battle.tscn") # Load the battle into the game
	battleUI = currBattle.get_node("BattleUI") # Update the battle UI
	currBattle.laneSelected.connect($"Unit Spawner"._on_battle_lane_selected) # Connect the unit spawning signal
	inBattle = true
	
	#$Battle/BattleUI.receiveUnit(loadedUnits[0][0], loadedUnits[0][1])
	
	#$Battle/BattleUI.receiveUnit(loadedUnits[0][0], loadedUnits[0][1], loadedUnits[0][2])
	#$Battle/BattleUI.receiveUnit(loadedUnits[1][0], loadedUnits[1][1], loadedUnits[1][2])
	#$Battle/BattleUI.receiveUnit(loadedUnits[2][0], loadedUnits[2][1], loadedUnits[2][2])
	#$Battle/BattleUI.receiveUnit(loadedUnits[3][0], loadedUnits[3][1], loadedUnits[3][2])
	
	for i in range(4):
		if (loadedUnits[i][1] != "NO_UNIT"):
			battleUI.receiveUnit(loadedUnits[i][0], loadedUnits[i][1], loadedUnits[i][2])
	pass

func _on_battle_win_con(side: Variant) -> void:
	if(side == "Wizards"):
		print("we won!!!")
	else:
		print("we lost...")
