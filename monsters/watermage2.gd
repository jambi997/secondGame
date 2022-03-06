extends KinematicBody2D

enum states { CHILL, NORMALCAST, BIGCAST}

#var targets = [1, 2, 3 ,4 ,5]
var state
var aspeed = 2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 120
var starthp = 6000
var hp = starthp
var chargespeed = 500
var basedamage = 100
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
var danger = 400
var standstill = false
var canturn = 1
var posa
var posb 
var targets = [] 
var defense = 40
var wakeup = false
var fball = preload("res://monsters/waterthing.tscn")
var parent
var swarmcount = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	state = states.CHILL
	parent = get_parent()
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
func wakeup():
	blocked = false
	wakeup = true
	
	

	#$AnimationPlayer.play("attack")
	
	
func _physics_process(delta):
	choose_action()
	while hp < starthp * 0.9 and wakeup == false:
		wakeup()
	#$CollisionShape2D.position.x = $Position2D.position.x
	if hp < (starthp / 2):
		state = states.BIGCAST
		#aspeed = 0.3
	elif hp < (starthp / 2) and hp > (starthp / 5):
		pass
		#aspeed = 0.3
	
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
	


func spawnball(pos):
	#fball = fball.instance()
	#fball.start_at(pos)
	#add_child(fball)
	
	#canshoot= false
	#if blocked == false:
	var b = fball.instance()
	b.start_at(pos)
	b.modulate = modulate
	#$bullet.add_child(b)
	parent.add_child(b)
	#$shoottimer.start()
	#$shoottimer.wait_time = parent.aspeed
	
	#wakeup = true
func swarmball(amount):
	for i in amount:
		var rand = RandomNumberGenerator.new()
		var enemy = fball.instance()# = playerch.instance()
		rand.randomize()
		var x = rand.randf_range(-320, 320)
		var y = rand.randf_range(70, 200)
		enemy.position.y = y
		enemy.position.x = x
		spawnball(enemy.position)

func sceemtarget():
	var led = len(targets)
	if led > 0:
		var maxi = targets[0]
		for i in range(1, led):
			if targets[i] != null: #and targets[0] != null:
				if targets[0] == null:
					led = len(targets)
					targets[0] = targets[led]
				if targets[i].threath > targets[0].threath:
					target = target[0]
					targets[0] = targets[i]
					target[i] = target
		#target = maxi

func choose_action():
	velocity = Vector2.ZERO
	var led = len(targets)
	if led > 0:
		var maxi = targets[0]
		for i in range(0, led):
			if targets[i] != null:
				if targets[i].threath > maxi.threath:
					maxi = targets[i]
		target = maxi


	$shadow/test/ColorRect/astimer.wait_time = aspeed

	match state:
		states.CHILL:
			velocity = Vector2.ZERO
			$AnimationPlayer.play("idle")
			#$test/ColorRect/fleetimer.start()
		states.NORMALCAST:
			if blocked == false:
				$shadow/test.frame = 0
				#sceemtarget()
				led = len(targets)
				if target != null:
					spawnball(target.position)
				if led >= 3:
					pass
					#targets.shuffle()
					#spawnball(targets[1].position)
				$shadow/test/ColorRect/astimer.start()
				blocked = true
			else:
				$shadow/test.frame = 0
			pass
			
		states.BIGCAST:
			if blocked == false:
				swarmcount += 1 
				$shadow/test.frame = 1
				if target != null:
					spawnball(target.position)
				$shadow/test/ColorRect/spelltimer.wait_time = 2
				aspeed = 1
				#sceemtarget()
				#spawnball(targets[0].position)
				#spawnball(targets[1].position)
				#blocked = true
				led = len(targets)
				if led > 0:
					for i in range(0, led):
					#	spawnball(targets[i].position)
						i += 1 
				blocked = true
				$shadow/test/ColorRect/astimer.start()
			
			
			





func _on_sense_body_entered(body):
	targets.append(body)
	state = states.NORMALCAST
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









func _on_attacksense_area_entered(area):
	if target != null and area.is_in_group("hurtbox"):
		pass
		#state = states.ATTACK



func _on_attacksense_area_exited(area):
	if target != null  :
		pass
		#state = states.CHASE


func _on_attack_area_entered(area):
	danger += damage






func _on_astimer_timeout():
	blocked = false





func _on_chargetimer_timeout():
	#blocked = false
	pass


		#$shadow/test/ColorRect/sense/CollisionShape2D.disabled = true





func _on_attack_area_exited(area):
	pass # Replace with function body.


func _on_spelltimer_timeout():
	swarmball(swarmcount)
	pass # Replace with function body.
