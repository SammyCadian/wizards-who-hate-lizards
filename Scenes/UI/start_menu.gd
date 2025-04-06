extends Node2D

func _on_button_pressed() -> void:
	get_parent().loadScene("res://Scenes/UI/exposition.tscn")
