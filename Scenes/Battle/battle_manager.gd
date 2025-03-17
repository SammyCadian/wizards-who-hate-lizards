extends Node2D

var loadableunits = [[2, "potato"], [3, "yes"]]

func startBattle(loadedUnits: Array):
	$Battle/BattleUI.receiveUnit(loadedUnits[0][0], loadedUnits[0][1])
	pass
