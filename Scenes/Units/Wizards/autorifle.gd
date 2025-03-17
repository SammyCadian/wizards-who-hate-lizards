extends CharacterBody2D

@onready var see_enemy = false
@export var damage = 1
var health = 30
var damageTaken = 0
#var isDead = false
var deathTimer = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "walk"
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
		velocity = Vector2(50, 0)  
	move_and_slide()


func WizardDamage() -> int:
	return damage


func _on_range_area_body_entered(body: Node2D) -> void:
	$AnimatedSprite2D.animation = "attack"
	see_enemy = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	$AnimatedSprite2D.animation = "walk"
	see_enemy = false


func _on_damage_timer_timeout() -> void:
	health -= damageTaken
	print("Auto mage health: " + str(health))
	if(health <= 0):
		$DamageTimer.stop()
		ouchieMyForehead()


func ouchieMyForehead():
	deathTimer = 2.5
	velocity = Vector2(0, 0)
	get_node("RangeArea").free()
	get_node("HitboxArea").free()
	get_node("CollisionShape2D").free()


func _on_hitbox_area_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("LizardDamage"):
		var node = area.get_parent() as Node
		damageTaken += node.LizardDamage()
		$DamageTimer.start()


func _on_hitbox_area_area_exited(area: Area2D) -> void:
	if area.get_parent().has_method("LizardDamage"):
		var node = area.get_parent() as Node
		damageTaken -= node.LizardDamage()
