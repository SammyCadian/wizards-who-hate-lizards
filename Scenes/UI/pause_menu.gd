extends Control

func _on_resume_pressed() -> void:
	get_parent().inMenu = false
	queue_free()

func _on_restart_pressed() -> void:
	get_parent().restartGame()
	queue_free()

func _on_quit_pressed() -> void:
	get_tree().quit()
