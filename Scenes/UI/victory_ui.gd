extends Control

func _on_button_pressed() -> void:
	pass

func _on_damage_upgrade_pressed() -> void:
	pass

func _on_health_upgrade_pressed() -> void:
	pass

func nuhUhProtocol():
	$Nuhuh.visible = true
	$Nuhuh/ColorRect.visible = true
	$NuhUhTimer.start()

func _on_nuh_uh_timer_timeout() -> void:
	$Nuhuh.visible = false
	$Nuhuh/ColorRect.visible = false
	$NuhUhTimer.stop()
	pass # Replace with function body.
		
