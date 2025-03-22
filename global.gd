extends Node

func _ready() -> void:
	pass
	#startBattle()
# Everything in here can be accessed from other scripts using Global.VAR_NAME
func startBattle():
	
	print($UnitSelection.getUnits())
	get_node("BattleManager").startBattle($UnitSelection.getUnits())
	


func _on_unit_selection_start_game() -> void:
	startBattle()
	pass # Replace with function body.
