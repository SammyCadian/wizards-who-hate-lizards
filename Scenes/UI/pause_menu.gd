extends Control

func _on_resume_pressed() -> void:
	get_parent().resumeGame()

func _on_restart_pressed() -> void:
	get_parent().zaWarudo(false)
	get_parent().get_node("BattleManager").inBattle = false
	get_parent().get_node("Camera2D").set_zoom(Vector2(0.6, 0.6))
	get_parent().paused = false
	get_parent().restartGame()
	queue_free()

func _on_quit_pressed() -> void:
	get_tree().quit()
