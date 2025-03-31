extends Control

func _ready() -> void:
	pass

func _on_button_pressed() -> void:
	get_parent().get_parent().selectedItem = self
	print(name + " item selected!")
