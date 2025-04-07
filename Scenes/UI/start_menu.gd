extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("moveystuff")

func _on_button_pressed() -> void:
	get_parent().loadScene("res://Scenes/UI/exposition.tscn")
