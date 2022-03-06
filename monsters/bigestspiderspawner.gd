extends KinematicBody2D

enum states {CHASE, ATTACK, CHILL, FLEE, CHARGE}

#var targets = [1, 2, 3 ,4 ,5]
var state
var aspeed = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 120
var starthp = 2000
var hp = starthp
var chargespeed = 500
var basedamage = 70
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
var danger = 0
var standstill = false
var canturn = 1
var posa
var posb 
var targets = [] 
var defense = 50
var wakeup = false
var spider = preload("res://monsters/spider.tscn")
var parent
var canusecc = 0
var spawncount = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
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
	var taken = (amount - (amount * (float(defense)/ 100)))
	hp -= (amount - (amount * (float(defense)/ 100)))
	#if taken > 20:
		#spawncount += 0.1
	
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
	
func spawnspider(amount):
	for i in amount:
		var rand = RandomNumberGenerator.new()
		var enemy = spider.instance()# = playerch.instance()
		rand.randomize()
		var x = rand.randf_range(-320, 320)
		var y = rand.randf_range(100, 150)
		enemy.danger(5000)
		enemy.global_position.y = y
		enemy.global_position.x = x
		enemy.starthp = 40
		enemy.hp = 40
		enemy.damage = 20
		enemy.basedamage = 20
		enemy.damage = 20
		enemy.scale.x = 0.5
		enemy.scale.y = 0.5
		parent.add_child(enemy)
	
func _physics_process(delta):
	choose_action()
	while hp < starthp * 0.9 and wakeup == false:
		wakeup()
	#$CollisionShape2D.position.x = $Position2D.position.x
	if hp < starthp / 2 and canusecc <= 5:
		spawnspider(2)
		canusecc += 1
		
	if spawncount >= 40:
		spawnspider(3)
		spawncount = 0
		
		
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
				$AnimationPlayer.play("run")
				velocity = (target.position - position).normalized() * speed
			else:
				$AnimationPlayer.play("idle")
			
		states.ATTACK:
			
			damage = basedamage
			if blocked == false:
				$AnimationPlayer.play("attack2")
					#weapon.attack()
				$shadow/test/ColorRect/astimer.start()
				blocked = true
				chargemeter = 0
				spawncount += 0.1
		states.CHILL:
			velocity = Vector2.ZERO
			$AnimationPlayer.play("idle")
			#$test/ColorRect/fleetimer.start()

			
			
			
			





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
		spawncount += 2








func _on_attacksense_area_entered(area):
	if target != null and area.is_in_group("hurtbox"):
		state = states.ATTACK



func _on_attacksense_area_exited(area):
	if target != null and area.is_in_group("hurtbox")  :
		state = states.CHASE


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



# Declare member variables here. Examples:


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
