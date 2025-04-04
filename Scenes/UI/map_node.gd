extends Control

@export var nodeType = ""

func _ready() -> void:
	# Start disabled and hidden in the map
	disable()
	hide()

func _on_button_pressed() -> void:
	get_parent().get_parent().selectedMapNode = self
	print(name + " node selected!")

func disable():
	$DisabledCover.show()
	$RedX.show()
	$Button.hide()
	$Button.disabled = true
	
func enable():
	$DisabledCover.hide()
	$RedX.hide()
	$Button.show()
	$Button.disabled = false
