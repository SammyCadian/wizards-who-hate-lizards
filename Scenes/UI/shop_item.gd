extends Control

func _ready() -> void:
	disable()

func _on_button_pressed() -> void:
	get_parent().get_parent().selectedItem = self
	print(name + " ability selected!")

func disable():
	$BoughtCover.show()
	$Button.hide()
	$Button.disabled = true
	
func enable():
	$BoughtCover.hide()
	$Button.show()
	$Button.disabled = false
