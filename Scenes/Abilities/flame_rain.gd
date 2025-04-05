extends Node2D

@export var projectile: PackedScene
var projNum = 8
var deviationRange = 50

func setTarget(newPos):
	position = newPos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#for i in range(projNum):


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if projNum > 0:
		var newProj = projectile.instantiate()
		var randX = deviationRange * RandomNumberGenerator.new().randf_range(-1.0, 1.0)
		var randY = deviationRange * RandomNumberGenerator.new().randf_range(-1.0, 1.0)
		newProj.setTarget(position + Vector2(randX, randY))
		get_parent().add_child(newProj)
		projNum -= 1
	else:
		$DeletionTimer.start()


func _on_deletion_timer_timeout() -> void:
	queue_free()
