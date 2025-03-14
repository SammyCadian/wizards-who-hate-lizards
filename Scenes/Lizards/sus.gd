extends Node2D
var speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.play()
