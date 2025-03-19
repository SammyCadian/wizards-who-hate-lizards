extends Node2D

var loadableunits = [[2, "potato"], [3, "yes"]]

func startBattle(loadedUnits: Array):
	#$Battle/BattleUI.receiveUnit(loadedUnits[0][0], loadedUnits[0][1])
	
	#$Battle/BattleUI.receiveUnit(loadedUnits[0][0], loadedUnits[0][1], loadedUnits[0][2])
	#$Battle/BattleUI.receiveUnit(loadedUnits[1][0], loadedUnits[1][1], loadedUnits[1][2])
	#$Battle/BattleUI.receiveUnit(loadedUnits[2][0], loadedUnits[2][1], loadedUnits[2][2])
	#$Battle/BattleUI.receiveUnit(loadedUnits[3][0], loadedUnits[3][1], loadedUnits[3][2])
	
	for i in range(4):
		if(loadedUnits[i][1] != "NO_UNIT"):
			$Battle/BattleUI.receiveUnit(loadedUnits[i][0], loadedUnits[i][1], loadedUnits[i][2])
	pass

func _on_battle_win_con(side: Variant) -> void:
	if(side == "Wizards"):
		print("we won!!!")
	else:
		print("we lost...")
	pass # Replace with function body.
