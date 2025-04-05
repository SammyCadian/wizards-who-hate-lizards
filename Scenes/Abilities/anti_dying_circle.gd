extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("alt")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_life_span_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	body.setAntiDeath(true)
	pass # Replace with function body.

func _on_body_exited(body: Node2D) -> void:
	body.setAntiDeath(false)
	pass # Replace with function body.
