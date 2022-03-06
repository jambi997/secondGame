extends KinematicBody2D

enum states {CHASE, ATTACK,CHILL}
var state
var aspeed = 0.7
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 90
var starthp = 100
var hp = starthp
var weap = Autoload.botw
#var target
var weapon
var target = null
var armor = Autoload.ruha
var armor2
var target1 = null
var startstam = 100
var stam = startstam
var blocked2





var target2 = null
var velocity = Vector2.ZERO
var blocked = false
var alive = true
export (int) var threath = 10
var wepc
# Called when the node enters the scene tree for the first time.
func _ready():
	state = states.CHILL
	weapon = weap.instance()
	$test/kez2/Position2D.add_child(weapon)
	alive = true
	$sense/CollisionShape2D.scale.x = 3
	$sense/CollisionShape2D.scale.y = 3
	wepc = weapon.get_child(0)
	#weapon.
	
	
func start_at(pos ):
	position = pos
	
	
func danger(amount):
	threath += amount 
	
	
func addweapon(weapons):
	weapon = weap.instance()
	
	$test/kez2/Position2D.add_child(weapon)
	#weapon = bot
	
func speedset(sped):
	aspeed = sped
	
func addarmor(armors):
	armor2 = armor.instance()
	$test.add_child(armor2)

func addhp(hape):
	starthp += hape

func heal(hale):
	hp += hale
	if hp > starthp:
		hp = starthp

func shield(amount):
	hp += amount

func setaspeed(amount):
	aspeed = amount

func take_damage(amount):
	if (amount - armor2.armor) > 0:
		hp -= amount - (amount * (armor2.armor/ 10))
	$test/hpbar.rect_size.x = 28 * hp / starthp
	if hp <= 0:
		alive = false
	if alive == false:
		queue_free()

func take_stamige(amount):
	stam -= amount
	$test/hpbar/rbar.rect_size.x = 25 * stam / startstam
	blocked2 = true
	$test/hpbar/stamtimer.start()
	
	
######################################################################################################################
	
	
	
func _physics_process(delta):
	choose_action()

	
	$Timer.wait_time = aspeed
	
	if velocity.x > 0:
		$test.scale.x = -1
	elif velocity.x < 0:
		$test.scale.x = 1
	#rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)

func choose_action():
	velocity = Vector2.ZERO

	if target1 != null and target2 != null:
		if target1.threath >= target2.threath :
			target = target1
		elif target1.threath < target2.threath :
			target = target2
	elif target1 != null and target2 == null:
		target = target1
	elif target2 != null and target1 == null:
		target = target2



	match state:
		states.CHASE:
			#target = target1
			
			velocity = (target.position - position).normalized() * speed
			
			
		states.ATTACK:
			if blocked == false:
				$AnimationPlayer.play("attack")
				weapon.attack()
				$Timer.start()
				blocked = true
		states.CHILL:
			velocity = Vector2.ZERO
	
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Timer_timeout():
	blocked = false








func _on_sense_body_entered(body):
	state = states.CHASE
	if target1 == null:
		target1 = body
	elif target2 == null and target1 != null and target1 != body:
		target2 = body
	#pass

func _on_sense_body_exited(body):
	if body == target1:
		target1 = null
	elif body == target2:
		target2 = null
	
	if target1 == null and target2 == null:
		state = states.CHILL





func _on_Area2D_area_entered(area):
	if target != null:
		state = states.ATTACK


func _on_Area2D_area_exited(area):
	if target != null:
		state = states.CHASE


func _on_AnimationPlayer_animation_finished(anim_name):
	if weapon.has_method("steady") :
		weapon.steady()


func _on_hitbox_area_entered(area):
	if area.is_in_group("damagebox") and area != wepc :
		var dmg = area.damage
		take_damage(dmg)





func _on_sense3_body_entered(body):
	if position.x <0:
		position.x += 10
	elif position.x >=0:
		position.x -= 10
	elif position.x == 0:
		position.x += 20
