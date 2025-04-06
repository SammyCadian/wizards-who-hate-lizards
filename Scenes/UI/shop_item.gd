extends Control

@export var cost : int = 0

func _ready() -> void:
	pass

func _on_button_pressed() -> void:
	get_parent().get_parent().selectedItem = self
	print(name + " item selected!")

func _on_button_mouse_entered() -> void:
	pass # Replace with function body.

func _on_button_mouse_exited() -> void:
	pass # Replace with function body.
