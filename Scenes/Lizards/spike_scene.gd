extends Node2D
@export var speed = -200 #Enemy speed
var attacking

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Placeholder defaults
	attacking = false
	$AnimatedSprite2D.animation = "walk"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Starts walking and plays animation when instantiated
	if (!attacking):
		$AnimatedSprite2D.play()
		position.x += round(speed*delta)
		
