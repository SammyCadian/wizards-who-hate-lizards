extends CharacterBody2D

@onready var see_enemy = false
@export var damage = 1
var shooting = false
var wasshooting = false
var health = 20
var speed = 30
var damage_multiplier = 1
var damageTaken = 0
#var isDead = false
var deathTimer = 0
var is_friendly = true
var antideath = false

func setAntiDeath(killable: bool):
	antideath = killable

var targets = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health *= Global.getHealthUpgrade()
	damage *= Global.getDamageUpgrade()
	speed += 10 * RandomNumberGenerator.new().randf()
	z_index = global_position.y + 200
	$AnimatedSprite2D.animation = "walk"
	$AnimatedSprite2D.play()
	enterAudio()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shooting != wasshooting:
		if shooting:
			$Gunshot.play(0.0)
		wasshooting = shooting
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
		velocity = Vector2(speed, 0)  
	move_and_slide()


func WizardDamage() -> int:
	return damage


func _on_range_area_body_entered(body: Node2D) -> void:
	targets.append(body)
	$DamageTimer.start()
	shooting = true
	$AnimatedSprite2D.animation = "attack"
	see_enemy = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if(targets.has(body)):
		targets.remove_at(targets.find(body))
	if(targets.size() <= 0):
		$Gunshot.stop()
		shooting = false
		$DamageTimer.stop()
		$AnimatedSprite2D.animation = "walk"
		see_enemy = false

func _on_damage_timer_timeout() -> void:
	if(targets.size() > 0):
		var targetAmount = min(targets.size(), 3)
		for i in range(targetAmount):
			#$Gunshot.play(0.0)
			targets[i].takeDamage(damage)

func enterAudio():
	var yes = RandomNumberGenerator.new().randf()
	if yes > 0.67:
		$SpawnA.play(0.0)
	elif yes > .33:
		$SpawnB.play(0.0)
	else:
		$SpawnC.play(0.0)
		
func takeDamage(damage: int):
	health -= damage
	if(health <= 0):
		if antideath:
			health = 1
		else:
			ouchieMyForehead()
		
func ouchieMyForehead():
	deathTimer = 2.5
	velocity = Vector2(0, 0)
	if get_node("RangeArea") != null:
		get_node("RangeArea").free()
		get_node("HitboxArea").free()
		get_node("CollisionShape2D").free()


#func _on_hitbox_area_area_entered(area: Area2D) -> void:
	#if area.get_parent().has_method("LizardDamage"):
		#var node = area.get_parent() as Node
		#damageTaken += node.LizardDamage()
		#$DamageTimer.start()
#
#
#func _on_hitbox_area_area_exited(area: Area2D) -> void:
	#if area.get_parent().has_method("LizardDamage"):
		#var node = area.get_parent() as Node
		#damageTaken -= node.LizardDamage()
