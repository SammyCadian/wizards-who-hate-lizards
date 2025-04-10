extends Node2D

var explodableUnits = []
var Ammoleft
var fireReady
var readyToDie = false

func setTarget(target: Vector2):
	position = target
	z_index = 1500 + global_position.y

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Ammoleft = 8
	fireReady = true
	$AnimatedSprite2D.play("Waiting")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Ammoleft <= 0:
		readyToDie = true
	elif fireReady && explodableUnits.size() > 0:
		fireReady = false
		Ammoleft -= 1
		for i in range(explodableUnits.size()):
			explodableUnits[i].takeDamage(20)
		$AnimatedSprite2D.play("Shoot")
		$AudioStreamPlayer2D.play(0.0)


func _on_animated_sprite_2d_animation_finished() -> void:
	if readyToDie: 
		queue_free()
	$AnimatedSprite2D.play("Waiting")
	fireReady = true

func _on_body_entered(body: Node2D) -> void:
	explodableUnits.append(body)


func _on_body_exited(body: Node2D) -> void:
	explodableUnits.remove_at(explodableUnits.find(body))
