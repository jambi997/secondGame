extends KinematicBody2D

enum states {CHASE, ATTACK, CHILL, FLEE, CHARGE}

#var targets = [1, 2, 3 ,4 ,5]
var state
var aspeed = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 50
var starthp = 2000
var hp = starthp
var chargespeed = 500
var basedamage = 50
var chargemeter = 20
#var target
var chargetarget = null
var weapon
var target = null
var target1 = null
var target2 = null
var velocity = Vector2.ZERO
var blocked = true
var alive = true
export (int) var threath = 10
export (int) var damage = basedamage
var danger = 300
var standstill = false
var canturn = 1
var posa
var posb 
var targets = []
var wakeup = false
# Called when the node enters the scene tree for the first time.
func _ready():
	state = states.CHILL

	alive = true
	$shadow/test/ColorRect/sense/CollisionShape2D.scale.x = 20
	$shadow/test/ColorRect/sense/CollisionShape2D.scale.y = 20
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
	hp -= amount
	if hp <= 0:
		alive = false
	if alive == false:
		#addloot()
		#addbossloot()
		#addloot()
		queue_free()
	$shadow/test/ColorRect.rect_size.x = 38 * hp / starthp
 
	$Label.set_text(str(hp))
	
	
	
	
#################################################################################################################
func wakeup():
	blocked = false
	wakeup = true
	
	
func _physics_process(delta):
	choose_action()
	while hp < starthp * 0.9 and wakeup == false:
		wakeup()
	
	canturn += 1
	$shadow/test/ColorRect/astimer.wait_time = aspeed
	#$ColorRect..x = $test.scale.x
	#$Label.text = chargemeter
	if velocity.x > 0 and canturn > 10:
		$shadow.scale.x = -1.8
		canturn = 1
		#$CollisionShape2D.position.x = posb
		#$Position2D.position.x = 10.57
	elif velocity.x < 0 and canturn > 10:
		$shadow.scale.x = 1.8
		canturn = 1
		#$CollisionShape2D.position.x = posa
		#$Position2D.position.x = -10.57
	$shadow/test/ColorRect/attack.damage = damage
	#rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
	
	
	if $shadow/test/ColorRect/sense/CollisionShape2D.disabled == true:
			$shadow/test/ColorRect/sense/CollisionShape2D.disabled = false
	






func choose_action():
	velocity = Vector2.ZERO
	var led = len(targets)
	if led > 0 and hp > starthp / 4:
		var maxi = targets[0]
		for i in range(1, led):
			if targets[i].threath > maxi.threath:
				maxi = targets[i]
		target = maxi
	elif hp < starthp / 4 and led > 0  :
		var maxi = targets[0]
		for i in range(1, led):
			if targets[i].threath < maxi.threath:
				maxi = targets[i]
		target = maxi
		#chargemeter += 2

	match state:
		states.CHASE:
			#target = target1
			if blocked == false and target != null : #and (target.position - position) > Vector2(0, 0)*0.1 :
				$AnimationPlayer.play("run")
				velocity = (target.position - position).normalized() * speed
			else:
				$AnimationPlayer.play("idle")
			
		states.ATTACK:
			
			damage = basedamage
			if blocked == false:
				$AnimationPlayer.play("attack")
					#weapon.attack()
				$shadow/test/ColorRect/astimer.start()
				blocked = true
				chargemeter = 0
		states.CHILL:
			velocity = Vector2.ZERO
			$AnimationPlayer.play("idle")
			#$test/ColorRect/fleetimer.start()
		states.FLEE:
			#$Timer2.start()
			if target != null:
				velocity = (position - target.position).normalized() * speed
				$AnimationPlayer.play("run")
		states.CHARGE:
			if blocked == false:
			#if target != null:
				$AnimationPlayer.play("charge")
				velocity = Vector2( -$shadow.scale.x*chargespeed, 0)#.normalized() * chargespeed           #(chargetarget.position - position).normalized() * chargespeed
				damage = basedamage + 10
				#$test/ColorRect/attack/CollisionShape2D.disabled = false
				#blocked = true
			
			
			
			




func _on_sense_body_entered(body):
	if state != states.ATTACK:
		state = states.CHASE
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


func trash():
	if position.x <0:
		position.x += 10
	elif position.x >=0:
		position.x -= 10
	elif position.x == 0:
		position.x += 20






func _on_attacksense_area_entered(area):
	if target != null and state != states.CHARGE and area.is_in_group("hurtbox"):
		state = states.ATTACK



func _on_attacksense_area_exited(area):
	if target != null and state != states.CHARGE and area.is_in_group("hurtbox") :
		state = states.CHASE


func _on_attack_area_entered(area):
	danger += damage





func _on_fleetimer_timeout():
	#blocked = false
	#$AnimationPlayer.play("reset")
	#$sense/CollisionShape2D.disabled = false
	if target != null:
		state = states.CHASE

func _on_astimer_timeout():
	blocked = false





func _on_chargetimer_timeout():
	#blocked = false
	if chargemeter < 15 and target != null :
		if state != states.ATTACK: #or chargemeter < 1:
			state = states.CHASE
		#$shadow/test/ColorRect/attack/CollisionShape2D.disabled = true
			#blocked = false
		chargemeter += 5
	elif chargemeter >= 15 and wakeup == true:	
		state = states.CHARGE
		chargemeter = 0
		blocked = false

		#$shadow/test/ColorRect/sense/CollisionShape2D.disabled = true


func _on_chargesense_body_entered(body):
	#if body == target:
	#standstill = true
	chargemeter -= 5
	#if target != null:
	#	chargetarget = target
		#state = states.CHARGE
		#$test/ColorRect/chargesense/chargetimer.start()


func _on_chargesense_body_exited(body):
	standstill = false


func _on_hitbox_area_exited(area):
	pass # Replace with function body.


func _on_attack_area_exited(area):
	pass # Replace with function body.
