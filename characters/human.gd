extends KinematicBody2D



var velq = true
var velocity = Vector2()
var startspeed = 100
var speed = startspeed
var starthp = 100
var startstam = 100
var stam = startstam
var hp = starthp
var damage = 10
var bot2 = load(Autoload.wep) #preload("res://weapons/bot.tscn") 
var armor = load(Autoload.ruha)
var armor2
var bot
var weap = load(Autoload.wep)
var bot3
var defense 
onready var weapon #= get_node("test/kez2/Position2D/bot")
var blocked = false
var blocked2 = false
var aspeed = 0.7
var mause = get_global_mouse_position()
var test = true
var alive = true
export (int) var threath = 10
var wepc
var cl
var nemszabad = false
var shield = 0

func _ready():
	#pas
	#weapon = weap.instance()
	armor2 = armor.instance()
	defense = armor2.armor
	#$test/kez2/Position2D.add_child(weapon)
	#$test.add_child(armor2)
	addweapon()
	addarmor()
	alive = true
	wepc = weapon.get_child(0)
	#layers += 1
	#layers += 3

################################################functions############################################################
	
	
func start_at(pos ):
	position = pos
	
	
func danger(amount):
	threath += amount 
	
	
func addweapon():
	weap = load(Autoload.wep)
	
	weapon = weap.instance()
	$test/kez2/Position2D.add_child(weapon)
	
func speedset(sped):
	aspeed = sped
	
func addarmor():
	armor = load(Autoload.ruha)
	armor2 = armor.instance()
	$test.add_child(armor2)

func addhp(hape):
	starthp += hape
	hp = starthp

func heal(hale):
	if hp < (starthp):
		hp +=  hale
		#if hp > starthp:
		#	hp = starthp
	#	hp = starthp

func shield(amount):
	shield += amount

func setaspeed(amount):
	aspeed = amount

func take_damage(amount):
	if shield > 0:
		shield -= amount
	#if (amount - defense) > 0:
	elif shield <=0:
		hp -= amount - (amount * (defense/ 100))
	#$hpbar.rect_size.x = 28 * hp / starthp
	if hp <= 0:
		alive = false
	if alive == false:
		queue_free()

func take_stamige(amount):
	stam -= amount
	#$test/hpbar/rbar.rect_size.x = 25 * stam / startstam
	blocked2 = true
	$bars/hpbar/stamtimer.start()

func dodging(amount, spedy):
	speed = speed*spedy
	$dodgetimer.wait_time = amount * 0.01
	$dodgetimer.start()





func _process(delta):
	if hp > starthp:
		#hp -= 0.1
		$bars/hpbar.color.g8 = 150
	elif hp <= starthp :
		$bars/hpbar.color.g8 = 0
	$bars/hpbar.rect_size.x = 28 * hp / starthp
	$bars/hpbar/rbar.rect_size.x = 25 * stam / startstam
	
	
#####################################################################################


func getinput():
	velocity = Vector2()
	if Input.is_action_pressed('down') and velq == false:
		velocity.y += 100
	if Input.is_action_pressed('up') and velq == false:
		velocity.y -= 100
	if Input.is_action_pressed('right') and velq == false:
		velocity.x += 120
		$test.scale.x = -1
	if Input.is_action_pressed('left') and velq == false:
		velocity.x -= 120
		$test.scale.x = 1
		
	if Input.is_action_pressed('attack1') and blocked == false and stam > 9:
		
		if test == true and weapon.is_in_group("melee"): #weapon.has_method("attack"):
			weapon.attack()
			blocked = true
			$AnimationPlayer.play("attack") 
			$Timer.start()
			if (position.x - mause.x)> 0 :
				$test.scale.x = 1
			elif (position.x - mause.x)< 0 :
				$test.scale.x = -1
		elif weapon.is_in_group("ranged"):
			
			$AnimationPlayer.play("shooting")
			$Timer.start()
			if (position.x - mause.x)> 0 :
				$test.scale.x = 1
			elif (position.x - mause.x)< 0 :
				$test.scale.x = -1
			weapon.attack()
			
			
	if Input.is_action_pressed('attack2') and blocked == false and stam > 9:
		pass
	if Input.is_action_pressed('dodge') and blocked == false and stam > 9 and nemszabad == true:
		dodging(1, 2)
		$AnimationPlayer.play('dodge')
	
	
	#	velocity = Vector2.ZERO
	$Timer.wait_time = aspeed
	velocity = velocity.normalized() * speed
		
	mause = get_global_mouse_position()
	velq = blocked
		



func _physics_process(delta):

	getinput()

	velocity = move_and_slide(velocity)



func _on_AnimationPlayer_animation_finished(anim_name):
	if weapon.has_method("steady") :
		weapon.steady()
		#block = true
	#if anim_name != "shooting":
	#	take_stamige(10)
		

func _on_AnimationPlayer_animation_started(anim_name):
	pass
		#block = false


func _on_Timer_timeout():
	blocked = false


func _on_Area2D_area_entered(area):
	if area.is_in_group("damagebox") and area != wepc :
		var dmg = area.damage
		take_damage(dmg)


func _on_stamtimer_timeout():
	if blocked2 == false and stam <= startstam :
		stam += 10
		if stam > 100:
			stam = 100
		#$bars/hpbar/rbar.rect_size.x = 25 * stam / startstam
	else:
		blocked2 = false


func _on_dodgetimer_timeout():
	speed = startspeed
	
	
	
	
