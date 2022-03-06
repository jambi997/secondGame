extends KinematicBody2D

enum states {CHASE, ATTACK, CHILL, FLEE}

#var targets = [1, 2, 3 ,4 ,5]
var state
var aspeed = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 90
var starthp = 100
var hp = starthp
var weap = load(Autoload.wep)
#var target
var weapon
var armor = load(Autoload.ruha2)
var armor2 = armor
var startstam = 100
var stam = startstam
var blocked2 = false
var defense = 0
var magicdefense = 0
var firedefense = 0
var icedefense = 0
var lightdefense = 0
var shadowdefense = 0
var shield = 0
var target = null
var target1 = null
var target2 = null
var velocity = Vector2.ZERO
var blocked = true
var alive = true
export (int) var threath = 10
var wepc
var canturn = 1
export (int) var id = 0
var canattack = false
var targets = []
var wakeup = false
var cango = false
var cangonext = false
# Called when the node enters the scene tree for the first time.
func _ready():
	#state = states.CHILL
	#weapon = weap.instance()
	#$test/kez2/Position2D.add_child(weapon)
	$AnimationPlayer.play("shooting")
	
	addarmor()
	addweapon()
	
	alive = true
	$sense/CollisionShape2D.scale.x = 5
	$sense/CollisionShape2D.scale.y = 5
	$sense/CollisionShape2D.disabled = false
	wepc = weapon.get_child(0)
	armor2 = armor.instance()
	defense += armor2.armor
	#$test.add_child(armor2)
	#layers += 3 
	#weapon.
	if weapon.is_in_group("ranged"):
		$test/Area2D/CollisionShape2D.scale.x = 160
		$test/Area2D/CollisionShape2D.scale.y = 0.1
		$test/Area2D/CollisionShape2D.disabled = true
		$AnimationPlayer.play("shooting")
########################################################################################################
		

		
func setrange(amount):
	$test/Area2D/CollisionShape2D.scale.x = amount
		
		
func start_at(pos ):
	position = pos
	
	
func danger(amount):
	threath += amount 
	
func adddefense(amount):
	defense += amount
	
func addweapon():
	match id:
		0:
			weap = load(Autoload.wep)
		1:
			weap = load(Autoload.wep1)
		2:
			weap = load(Autoload.wep2)
		3:
			weap = load(Autoload.wep3)
		4:
			weap = load(Autoload.wep4)
			
	weapon = weap.instance()
	$test/kez2/Position2D.add_child(weapon)
	#weapon = bot
	
func speedset(amount):
	speed += amount
	
func addarmor():
	match id:
		0:
			armor = load(Autoload.ruha)
		1:
			armor = load(Autoload.ruha1)
		2:
			armor = load(Autoload.ruha2)
		3:
			armor = load(Autoload.ruha3)
		4:
			armor = load(Autoload.ruha4)
	armor2 = armor.instance()
	$test/ruhahely.add_child(armor2)
	#$test.add_child(armor2)

func addhp(hape):
	starthp += hape
	hp = starthp
	if starthp <= 0:
		queue_free()

func heal(hale):
	if hp < (starthp):
		hp +=  hale
		#if hp > starthp:
		#	hp = starthp
	#	hp = starthp

func shield(amount):
	shield += amount



func setaspeed(amount):
	addattackspeed(amount)
	#aspeed += amount
	#aspeed = (amount * 0.1) * aspeed
func addattackspeed(amount):
	aspeed = aspeed * amount
	#aspeed = (amount * 0.1) * aspeed
	
	
func take_damage(amount):
	if shield > 0:
		shield -= amount
	#if (amount - defense) > 0:
	elif shield <=0:
		hp -= (amount - (amount * (float(defense)/ 100)+(float(lightdefense)/ 100)))
		threath -= (amount - (amount * (float(defense)/ 100)+(float(lightdefense)/ 100)))
	#$hpbar.rect_size.x = 28 * hp / starthp
	if hp <= 0:
		alive = false
	if alive == false:
		queue_free()

func take_stamige(amount):
	stam -= amount
	#$hpbar/rbar.rect_size.x = 25 * stam / startstam
	blocked2 = true
	$bars/hpbar/stamtimer.start()
	
	
	
	
func _process(delta):
	if hp > starthp:
		hp -= 2
	if shield > starthp:
		shield -= 2
		#bars/hpbar.color.g8 = 150
	elif hp <= starthp :
		$bars/hpbar.color.g8 = 0
	if starthp != 0:
		$bars/hpbar.rect_size.x = 28 * hp / starthp
		$bars/hpbar/rbar.rect_size.x = 25 * stam / startstam
		$bars/shieldbar.rect_size.x = 28* shield / starthp
	
#################################################################################################
	
func wakeup():
	$Timer.start()
	#blocked = false
	wakeup = true
	
func _physics_process(delta):
	choose_action()
	while wakeup == false and hp < starthp * 0.9:
		wakeup()
	
	if aspeed < 0.30:
		$Timer.wait_time = 0.30
	else:
		$Timer.wait_time = aspeed
	
	$Timer.wait_time = aspeed
	canturn += 1
	if velocity.x > 0 and canturn > 10:
		$test.scale.x = -1
		canturn = 1
	elif velocity.x < 0 and canturn > 10:
		$test.scale.x = 1
		canturn = 1
	#rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)

func choose_action():
	velocity = Vector2.ZERO

	var led = len(targets)
	if led > 0 :
		var maxi = targets[0]
		for i in range(1, led):
			if targets[i].threath > maxi.threath:
				maxi = targets[i]
		target = maxi

	while canattack == true and state != states.ATTACK :
		state = states.ATTACK
	#elif state != states.ATTACK:
	#	$AnimationPlayer.play("resetattack")


	match state:
		states.CHASE:
			if blocked == false :
				if  weapon.is_in_group("melee") or cangonext == true:
					$AnimationPlayer.play("run")
					velocity = (target.position - position).normalized() * speed
				elif weapon.is_in_group("ranged") and target != null and cangonext == false:
					$AnimationPlayer.play("run")
					velocity.y = (target.position.y - position.y) #* (speed) * 0.03)
					velocity = velocity.normalized()* speed
		states.ATTACK:
			if blocked == false :
				if  weapon.is_in_group("melee"): #weapon.has_method("attack"):
					weapon.attack()
					blocked = true
					$AnimationPlayer.play("attack") 
					$Timer.start()

				elif weapon.is_in_group("ranged") and target != null:
					if (position.x - target.position.x)> 0 :
						$test.scale.x = 1
					elif (position.x - target.position.x)< 0 :
						$test.scale.x = -1
					$AnimationPlayer.play("shooting")
					$Timer.start()
					blocked = true
					weapon.attack()
					#if target != null:
					#	$test/kez2/Position2D.look_at(target.global_position)

		states.CHILL:
			velocity = Vector2.ZERO
			$Timer2.start()
		states.FLEE:
			#$Timer2.start()
			if target != null:
				velocity = (position - target.position).normalized() * speed
	
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Timer_timeout():
	blocked = false








func _on_sense_body_entered(body):
	if state != states.ATTACK:
		state = states.CHASE
	targets.append(body)
	if body.is_in_group("door"):
		cangonext = true
	#targets.1 = body
	
	
	#pass
	
	

func _on_sense_body_exited(body):
	targets.erase(body)
	var led = len(targets)
	if led < 1:
		state = states.CHILL





func _on_Area2D_area_entered(area):
	if target != null and area.is_in_group("hurtbox"):
		#state = states.ATTACK
		canattack = true

func _on_Area2D_area_exited(area):
	
	if target != null and area.is_in_group("hurtbox"):
		state = states.CHASE
	#if area == target:
		canattack = false

func _on_AnimationPlayer_animation_finished(anim_name):
	if weapon.has_method("steady") :
		weapon.steady()

func _on_hitbox_area_entered(area):
	if area.is_in_group("damagebox") and area != wepc:
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
	#state = states.FLEE
	#blocked = true
	pass


func _on_Timer2_timeout():
	blocked = false
	#$AnimationPlayer.play("reset")
	#$sense/CollisionShape2D.disabled = false
	if target != null:
		state = states.CHASE


func _on_sense3_body_exited(body):
	$Timer2.start()
	#pass


func _on_resettimer_timeout():
	if state != states.ATTACK:
		$AnimationPlayer.play("resetattack")
	blocked = false
	#pass

func _on_stamtimer_timeout():
	if state != states.ATTACK and stam <= startstam  :
		stam += 10
		if stam > 100:
			stam = 100
		#$test/hpbar/rbar.rect_size.x = 25 * stam / startstam
	else:
		blocked2 = false
