extends Node2D

func _on_button_pressed() -> void:
	get_parent().get_parent().selectedMapNode = self
	print(name + " node selected!")
