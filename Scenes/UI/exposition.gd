extends Control

func _on_button_pressed() -> void:
	get_parent().loadMap()


func _on_godscout_pressed() -> void:
	Global.GET_GOD_SCOUT()
	$ColorRect/GODSCOUT/Label.show()
