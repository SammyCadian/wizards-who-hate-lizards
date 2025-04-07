extends Node2D

@export var damage:int = 50
var explodableUnits = []
var travelTime = 3.0
var timeTracker = 0.0
var exploded = false
var targetPos: Vector2 = Vector2.ZERO
var startPos: Vector2 = Vector2.ZERO

func setTarget(target: Vector2):
	position = (Vector2(target.x - 300, target.y - 3000))
	print(position)
	look_at(target)
	startPos = position
	targetPos = target

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("Missile")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timeTracker < travelTime:
		timeTracker += delta
		set_position(startPos + (timeTracker/travelTime) * (targetPos - startPos))
	elif not exploded:
		exploded = true
		$Kaboom.play(0.0)
		$AnimatedSprite2D.play("Explosion")
		$AnimatedSprite2D.position = Vector2.ZERO
		for i in range(explodableUnits.size()):
			explodableUnits[i].takeDamage(damage)


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	explodableUnits.append(body)
	pass # Replace with function body.

func _on_area_2d_body_exited(body: Node2D) -> void:
	explodableUnits.remove_at(explodableUnits.find(body))
	pass # Replace with function body.
