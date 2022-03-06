extends KinematicBody2D

enum states {CHASE, ATTACK, CHILL, FLEE, CHARGE}

var targets = [1, 2, 3 ,4 ,5]
var state
var aspeed = 0.7
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 50
var starthp = 500
var hp = starthp
var chargespeed = 500
var basedamage = 10
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
var danger = 300
var standstill = false
var canturn = 1
var posa
var posb 
var nemlehet = true
var targetek = []
# Called when the node enters the scene tree for the first time.
func _ready():
	state = states.CHILL

	alive = true
	$shadow/test/ColorRect/sense/CollisionShape2D.scale.x = 7
	$shadow/test/ColorRect/sense/CollisionShape2D.scale.y = 7
	$shadow/test/ColorRect/sense/CollisionShape2D.disabled = false

	posa = $CollisionShape2D.position.x
	posb = $CollisionShape2D.position.x * -1

	$Label.set_text(str(hp))
	#layers += 3 
	#weapon.
	
#############################################################################################################
	
	
func start_at(pos ):
	position = pos
	
func danger(amount):
	threath += amount 
	
func take_damage(amount):
	hp -= amount
	if hp <= 0:
		alive = false
	if alive == false:
		queue_free()
	$shadow/test/ColorRect.rect_size.x = 38 * hp / starthp
 
	$Label.set_text(str(hp))
	
	
	
	
#################################################################################################################
	
	
	
func _physics_process(delta):
	choose_action()
	
	#$CollisionShape2D.position.x = $Position2D.position.x
	
	
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
	$shadow/test/ColorRect/attack.damage = damage
	#rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
	
	
	if $shadow/test/ColorRect/sense/CollisionShape2D.disabled == true:
			$shadow/test/ColorRect/sense/CollisionShape2D.disabled = false
	


func targefind1():
	if target1 != null and target2 != null:
		if target1.threath >= target2.threath :
			target = target1
		elif target1.threath < target2.threath :
			target = target2
	elif target1 != null and target2 == null:
		target = target1
	elif target2 != null and target1 == null:
		target = target2

func targetfind2():
	#var s 
	int s = count(targetek)
	
	

func choose_action():
	velocity = Vector2.ZERO
	
	


	match state:
		states.CHASE:
			#target = target1
			if blocked == false and target != null and standstill == false: #and (target.position - position) > Vector2(0, 0)*0.1 :
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
		states.CHILL:
			velocity = Vector2.ZERO
			#$test/ColorRect/fleetimer.start()
		states.FLEE:
			#$Timer2.start()
			if target != null:
				velocity = (position - target.position).normalized() * speed
				$AnimationPlayer.play("run")
		states.CHARGE:
			#if target != null:
			$AnimationPlayer.play("charge")
			velocity = Vector2( -$shadow.scale.x*chargespeed, 0)#.normalized() * chargespeed           #(chargetarget.position - position).normalized() * chargespeed
			damage = basedamage *3
			#$test/ColorRect/attack/CollisionShape2D.disabled = false
			blocked = true
			
			
			
			




func _on_sense_body_entered(body):
	state = states.CHASE
	body.append(targetek)
	if nemlehet == false:
		if target1 == null:
			target1 = body
		elif target2 == null and target1 != null and target1 != body:
			target2 = body
	#targets.1 = body
	
	
	#pass
	
	

func _on_sense_body_exited(body):
	body.find(targetek)
	body.remove(targetek)
	if nemlehet == false:
		if body == target1:
			target1 = null
			$shadow/test/ColorRect/sense/CollisionShape2D.disabled = true
		elif body == target2:
			target2 = null
			$shadow/test/ColorRect/sense/CollisionShape2D.disabled = true
		if target1 == null and target2 == null:
			state = states.CHILL
			$shadow/test/ColorRect/sense/CollisionShape2D.disabled = true






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


func _on_sense3_body_entered(body):
	state = states.FLEE
	blocked = true



func _on_sense3_body_exited(body):
	$shadow/test/ColorRect/fleetimer.start()
	#pass







func _on_attacksense_area_entered(area):
	if target != null and state != states.CHARGE and area.is_in_group("hurtbox"):
		state = states.ATTACK



func _on_attacksense_area_exited(area):
	if target != null and state != states.CHARGE:
		state = states.CHASE


func _on_attack_area_entered(area):
	danger += 10





func _on_fleetimer_timeout():
	blocked = false
	#$AnimationPlayer.play("reset")
	#$sense/CollisionShape2D.disabled = false
	if target != null:
		state = states.CHASE

func _on_astimer_timeout():
	blocked = false





func _on_chargetimer_timeout():
	#blocked = false
	if chargemeter < 15 and target != null :
		if state != states.ATTACK or chargemeter < 1:
			state = states.CHASE
		$shadow/test/ColorRect/attack/CollisionShape2D.disabled = true
		blocked = false
		chargemeter += 1
	elif chargemeter >= 15:	
		state = states.CHARGE
		chargemeter = 1

	if target1 == null and target2 == null:
		state = states.CHILL
		$shadow/test/ColorRect/sense/CollisionShape2D.disabled = true


func _on_chargesense_body_entered(body):
	#if body == target:
		#standstill = true
	chargemeter += 4
	#if target != null:
	#	chargetarget = target
		#state = states.CHARGE
		#$test/ColorRect/chargesense/chargetimer.start()


func _on_chargesense_body_exited(body):
	standstill = false
