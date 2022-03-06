extends KinematicBody2D

enum states {CHASE, ATTACK, CHILL, FLEE, CHARGE}

#var targets = [1, 2, 3 ,4 ,5]
var state
var aspeed = 6
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 80
var starthp = 3333
var hp = starthp
var chargespeed = 500
var basedamage = 130
var chargemeter = 20
#var target
var chargetarget = null
var weapon
var target = null
var target1 = null
var target2 = null
var velocity = Vector2.ZERO
var blocked = false
var alive = true
export (int) var threath = 10
export (int) var damage = basedamage
var danger = 4000
var standstill = false
var canturn = 1
var posa
var posb 
var targets = [] 
var defense = 70
var fball = preload("res://monsters/mist.tscn")
var wakeup = false
# Called when the node enters the scene tree for the first time.
func _ready():
	state = states.CHILL

	alive = true
	$shadow/test/ColorRect/sense/CollisionShape2D.scale.x = 40
	$shadow/test/ColorRect/sense/CollisionShape2D.scale.y = 40
	$shadow/test/ColorRect/sense/CollisionShape2D.disabled = false

	posa = $CollisionShape2D.position.x
	posb = $CollisionShape2D.position.x * -1

	$Label.set_text(str(hp))
	#layers += 3 
	#weapon.
	
#############################################################################################################
	
func addloot():
	Autoload.bosszsakmany.shuffle()
	Autoload.loottable.append(Autoload.bosszsakmany[0])
	
func addbossloot():
	Autoload.rarezsakmany.shuffle()
	Autoload.loottable.append(Autoload.rarezsakmany[0])
	
	
func start_at(pos ):
	position = pos
	
func danger(amount):
	threath += amount 
	
func take_damage(amount):
	hp -= (amount - (amount * (float(defense)/ 100)))
	if hp <= 0:
		alive = false
	if alive == false:
		#addloot()
		#addbossloot()
		#addloot()
		queue_free()
	$shadow/test/ColorRect.rect_size.x = 50 * hp / starthp
 
	$Label.set_text(str(hp))
	
	
	
	
#################################################################################################################
	
	
	
func _physics_process(delta):
	choose_action()
	if hp < starthp * 0.95 and wakeup == false:
		fball = fball.instance()
		add_child(fball)
		wakeup = true
		$AnimationPlayer.play("attack")
	#$CollisionShape2D.position.x = $Position2D.position.x
	if hp < (starthp / 5):
		aspeed = 2
	elif hp < (starthp / 2) and hp > (starthp / 5):
		aspeed = 3
	
	canturn += 1
	$shadow/test/ColorRect/astimer.wait_time = aspeed
	#$ColorRect..x = $test.scale.x
	#$Label.text = chargemeter
	if velocity.x > 0 and canturn > 10:
		$shadow.scale.x = -1
		canturn = 1
		#$CollisionShape2D.position.x = posb
		#$Position2D.position.x = 10.57
	elif velocity.x < 0 and canturn > 10:
		$shadow.scale.x = 1
		canturn = 1
		#$CollisionShape2D.position.x = posa
		#$Position2D.position.x = -10.57
	#$shadow/test/ColorRect/attack.damage = damage
	#rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
	
	
	if $shadow/test/ColorRect/sense/CollisionShape2D.disabled == true:
			$shadow/test/ColorRect/sense/CollisionShape2D.disabled = false
	






func choose_action():
	velocity = Vector2.ZERO
	var led = len(targets)
	if led > 0:
		var maxi = targets[0]
		for i in range(1, led):
			if targets[i].threath > maxi.threath:
				maxi = targets[i]
		target = maxi


	match state:
		states.CHASE:
			#target = target1
			if blocked == false and target != null: #and (target.position - position) > Vector2(0, 0)*0.1 :
				#$AnimationPlayer.play("run")
				velocity = (target.position - position).normalized() * speed
			else:
				pass
				#$AnimationPlayer.play("idle")
			
		states.ATTACK:
			
			damage = basedamage
			$AnimationPlayer.play("attack")
					#weapon.attack()

		states.CHILL:
			velocity = Vector2.ZERO
			#$AnimationPlayer.play("idle")
			#$test/ColorRect/fleetimer.start()

			
			
			
			





func _on_sense_body_entered(body):
	#if state != states.ATTACK:
	#	state = states.CHASE
	targets.append(body)
	#targets.1 = body
	
	
	#pass
	
	

func _on_sense_body_exited(body):
	targets.erase(body)
	var led = len(targets)
	if led < 0:
		state = states.CHILL
	






func _on_hitbox_area_entered(area):
	if area.is_in_group("damagebox") :
		var dmg = area.damage
		take_damage(dmg)











func _on_astimer_timeout():
	blocked = false





func _on_chargetimer_timeout():
	#blocked = false
	pass


		#$shadow/test/ColorRect/sense/CollisionShape2D.disabled = true



