extends Node

func _ready() -> void:
	startBattle()
# Everything in here can be accessed from other scripts using Global.VAR_NAME
func startBattle():
	$"Battle Manager".startBattle($UnitSelection.getUnits())
	
