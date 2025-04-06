extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal death
@export var miniMissle:PackedScene
@export var damage = 10
@onready var see_enemy = false
var health = 300
var damageTaken = 0
#var isDead = false
var deathTimer = 0
var deviationRange = 500.0

var is_friendly = false

var mtargets = []
var targets = []

func _ready() -> void:
	$AnimatedSprite2D.animation = "walk"
	$AnimatedSprite2D.play()
	z_index = global_position.y + 200
	
	
func _process(delta: float) -> void:
	if(deathTimer > 0):
		$AnimatedSprite2D.animation = "death"
		deathTimer -= delta
		if(deathTimer < 0.5):
			queue_free()
	else:
		move()


func move():
	if see_enemy:
		velocity = Vector2(0, 0)   
	elif !see_enemy:
		velocity = Vector2(-10, 0)  
	move_and_slide()


func LizardDamage() -> int:
	return damage


func _on_damage_timer_timeout() -> void:
	if(targets.size() > 0):
		targets[0].takeDamage(damage)
	#health -= damageTaken
	#print("Scout health: " + str(health))
	#if(health <= 0):
		#$DamageTimer.stop()
		#ouchieMyForehead()

func takeDamage(damage: int):
	health -= damage
	if(health <= 0):
		deathTimer <= 0
		ouchieMyForehead()

func _on_range_area_body_entered(body: Node2D) -> void:
	targets.append(body)
	$DamageTimer.start()
	$AnimatedSprite2D.animation = "attack"
	see_enemy = true


func _on_range_area_body_exited(body: Node2D) -> void:
	if(targets.has(body)):
		targets.remove_at(targets.find(body))
	if(targets.size() <= 0):
		$DamageTimer.stop()
		$AnimatedSprite2D.animation = "walk"
		see_enemy = false

func ouchieMyForehead():
	death.emit()
	deathTimer = 2.5
	velocity = Vector2(0, 0)
	if get_node("RangeArea") != null:
		get_node("RangeArea").free()
		get_node("MissileRangeArea").free()
		get_node("HitboxArea").free()
		get_node("CollisionShape2D").free()


func _on_missile_range_area_body_entered(body: Node2D) -> void:
	if(mtargets.has(body)):
		mtargets.remove_at(mtargets.find(body))
	if(mtargets.size() <= 0):
		$MissileDamageTimer.stop()
	pass # Replace with function body.

func _on_missile_range_area_body_exited(body: Node2D) -> void:
	mtargets.append(body)
	$MissileDamageTimer.start()
	pass # Replace with function body.

func _on_missile_damage_timer_timeout() -> void:
	for i in range(4):
		var newMissle = miniMissle.instantiate()
		var randX = -(deviationRange * RandomNumberGenerator.new().randf())
		var randY =  150.0 * RandomNumberGenerator.new().randf_range(-1.0, 1.0)
		newMissle.setTarget(position + Vector2(randX, randY))
		get_parent().add_child(newMissle)
