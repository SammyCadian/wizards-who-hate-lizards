extends CharacterBody2D

@onready var see_enemy = false
var damage = 1
var health = 30
var damageTaken = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move()


func move():
	if see_enemy:
		velocity = Vector2(0, 0)   
	elif !see_enemy:
		velocity = Vector2(50, 0)  
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	see_enemy = true
	
	
	
func WizardDamage() -> int:
	return damage


func _on_area_2d_body_exited(body: Node2D) -> void:
	see_enemy = false


func _on_timer_timeout() -> void:
	health -= damageTaken
	print(health)
	if(health <= 0):
		$DamageTimer.stop()
		queue_free()


func _on_hitbox_area_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("LizardDamage"):
		var node = area.get_parent() as Node
		damageTaken += node.LizardDamage()
		$DamageTimer.start()


func _on_hitbox_area_area_exited(area: Area2D) -> void:
	if area.get_parent().has_method("LizardDamage"):
		var node = area.get_parent() as Node
		damageTaken -= node.LizardDamage()
