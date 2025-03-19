extends Node2D

var loadableunits = [[2, "potato"], [3, "yes"]]

func startBattle(loadedUnits: Array):
	#$Battle/BattleUI.receiveUnit(loadedUnits[0][0], loadedUnits[0][1])
	pass

func _on_battle_win_con(side: Variant) -> void:
	if(side == "Wizards"):
		print("we won!!!")
	else:
		print("we lost...")
	pass # Replace with function body.
