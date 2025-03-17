extends CharacterBody2D

@export var damage = 1

#var isDead = false
var deathTimer = 0
@onready var see_enemy = false
var health = 30
var damageTaken = 0


func _ready() -> void:
	$AnimatedSprite2D.animation = "walk"
	$AnimatedSprite2D.play()
	
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
		velocity = Vector2(-50, 0)  
	move_and_slide()

func _on_damage_timer_timeout() -> void:
	health -= damageTaken
	print("enemy: " , health)
	if(health <= 0):
		$DamageTimer.stop()
		ouchieMyForehead()


func _on_range_area_body_entered(body: Node2D) -> void:
	$AnimatedSprite2D.animation = "attack"
	see_enemy = true


func _on_range_area_body_exited(body: Node2D) -> void:
	$AnimatedSprite2D.animation = "walk"
	see_enemy = false

func ouchieMyForehead():
	deathTimer = 2.5
	velocity = Vector2(0, 0)
	get_node("RangeArea").free()
	get_node("HitboxArea").free()
	get_node("CollisionShape2D").free()

func LizardDamage() -> int:
	return damage


func _on_hitbox_area_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("WizardDamage"):
		var node = area.get_parent() as Node
		damageTaken += node.WizardDamage()
		$DamageTimer.start()
	pass # Replace with function body.


func _on_hitbox_area_area_exited(area: Area2D) -> void:
	if area.get_parent().has_method("WizardDamage"):
		var node = area.get_parent() as Node
		damageTaken -= node.WizardDamage()
	pass # Replace with function body.
