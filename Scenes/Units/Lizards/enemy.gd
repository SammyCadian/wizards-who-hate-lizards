extends CharacterBody2D

@onready var see_enemy = false
var damage = 1
var health = 30
var damageTaken = 0


func _ready() -> void:
	pass
	

func _process(delta: float) -> void:
	move()

func move():
	if see_enemy:
		velocity = Vector2(0, 0)   
	elif !see_enemy:
		velocity = Vector2(-50, 0)  
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("WizardDamage"):
		var node = area.get_parent() as Node
		damageTaken += node.WizardDamage()
		$DamageTimer.start()


func _on_damage_timer_timeout() -> void:
	health -= damageTaken
	print("enemy: " , health)
	if(health <= 0):
		$DamageTimer.stop()
		queue_free()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().has_method("WizardDamage"):
		var node = area.get_parent() as Node
		damageTaken -= node.WizardDamage()


func _on_range_area_body_entered(body: Node2D) -> void:
	print("fuck")
	see_enemy = true


func _on_range_area_body_exited(body: Node2D) -> void:
	see_enemy = false


func LizardDamage() -> int:
	return damage
