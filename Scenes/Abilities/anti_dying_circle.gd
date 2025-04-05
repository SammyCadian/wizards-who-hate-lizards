extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("alt")

func setTarget(newPos):
	#$LifeSpanTimer.start()
	position = newPos
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_life_span_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	body.setAntiDeath(true)

func _on_body_exited(body: Node2D) -> void:
	body.setAntiDeath(false)
