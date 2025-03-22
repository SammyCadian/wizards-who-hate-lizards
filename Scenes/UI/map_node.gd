extends Node2D

@export var nodeType = ""

func _on_button_pressed() -> void:
	get_parent().get_parent().selectedMapNode = self
	print(name + " node selected!")
