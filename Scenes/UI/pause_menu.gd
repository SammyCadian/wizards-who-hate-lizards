extends Control

func _ready() -> void:
	get_parent().zaWarudo(true)

func _on_resume_pressed() -> void:
	get_parent().inMenu = false
	get_parent().zaWarudo(false)
	queue_free()

func _on_restart_pressed() -> void:
	get_parent().zaWarudo(false)
	get_parent().restartGame()
	queue_free()

func _on_quit_pressed() -> void:
	get_tree().quit()
