extends Area2D

@export var laneEntered = false # Track when a cursor is in the lane

func _on_mouse_entered() -> void:
	if (get_parent().unitSelected):
		laneEntered = true
		$Highlight.show()

func _on_mouse_exited() -> void:
	laneEntered = false
	$Highlight.hide()
