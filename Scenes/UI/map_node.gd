extends Control

@export var nodeType = ""

func _ready() -> void:
	disable() # Start disabled in the map

func _on_button_pressed() -> void:
	get_parent().get_parent().selectedMapNode = self
	print(name + " node selected!")

func disable():
	$DisabledCover.show()
	$Button.hide()
	$Button.disabled = true
	
func enable():
	$DisabledCover.hide()
	$Button.show()
	$Button.disabled = false
