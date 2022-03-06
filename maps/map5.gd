extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var wcount =  250
const diszno = preload("res://monsters/boar4.tscn")
const spider = preload("res://monsters/spider.tscn")
const bigspider = preload("res://monsters/bigestspider.tscn")
const bigestspider = preload("res://monsters/bigestspiderspawner.tscn")
const pangulin = preload("res://monsters/pangulin.tscn")
const turtle = preload("res://monsters/turtle.tscn")
const watermage = preload("res://monsters/watermage.tscn")
const watermage2 = preload("res://monsters/watermage2.tscn")
const playerch = preload("res://characters/human3player.tscn")
const allies = preload("res://characters/human3.tscn")
var enemieslist = []
var allylist = []
var gamestate = "placing"
var szamol
var pressed = false
var mausepos
var spin = RandomNumberGenerator.new()
var loopin = false
var acroom #= allspawner()
var dummies = []
var wakeiwakei = false
var player = null
var floodcounter = 0
var rand = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	spin.randomize()
	rand.randomize()
	chooseroom()
	colorbackground()
	#gamestate = "combat"
	placeallies22()
	#placeplayerchar()
	starttheround()
	wakeiwakei = true
	$summonboss.hide()#.queue_free()
	#pass # Replace with function body.
	#spawner()
	#mobspawner()
	#mobspawner()
	#mobspawner()
	#mobspawner()
	#enemyspawn()
func floodstart():
	spin.randomize()
	floodcounter = spin.randi_range(5, 15)
	$Timer.start()
	
func placeallies():
	var rand = RandomNumberGenerator.new()
	#var enemy = spider.instance()
									#var room = rooms[1 + randi() % (rooms.size() - 1)]
	for i in range(5):
		var enemy = allies.instance()
		rand.randomize()
		var x = rand.randf_range(-200, -320)
		rand.randomize()
		var y = rand.randf_range(70, 200)
		enemy.position.y = y
		enemy.position.x = x								
		enemy.id = i
		#for i in range(4):
		$YSort.add_child(enemy)
		i += 1
		
func placeallies22():
	for i in range(5):
		var ally = allies.instance()
		ally.position = Autoload.postomb[i]
		ally.id = i
		$YSort.add_child(ally)
		i += 1
		
func placeplayerchar():
	var rand = RandomNumberGenerator.new()
	#var enemy = spider.instance()
									#var room = rooms[1 + randi() % (rooms.size() - 1)]
	for i in range(1):
		var enemy = playerch.instance()
		rand.randomize()
		var x = rand.randf_range(-250, -320)
		var y = rand.randf_range(70, 200)
		enemy.position.y = y
		enemy.position.x = x								
		#enemy.id = i
		#for i in range(4):
		$YSort.add_child(enemy)
		i += 1
	
func colorbackground():
	var randomgen = RandomNumberGenerator.new()
	randomgen.randomize()
	var rrr = randomgen.randi_range(1, 1)
	match rrr:
		1:
			$Sprite.self_modulate = Color("#00f9ff")
			#$Sprite2.self_modulate = Color("#3e4040")
		2:
			$Sprite.self_modulate = Color("#11c0c0")
			#$Sprite2.self_modulate = Color("#8c795b")
		3:
			$Sprite.self_modulate = Color("#ae9210")
			#$Sprite2.self_modulate = Color("#8c795b")
		4:
			$Sprite.self_modulate = Color("#625412")
			#$Sprite2.self_modulate = Color("#8c795b")
			
func chooseroom():
	#acroom = allspawner()
	match Autoload.levelstate:
		1:
			spawnert1()
			pass
		2:
			for i in 3:
				spawnert1()
			pass
		3:
			spawnert2()
			pass
		4:
			spawnert3()
		5:
			for i in 2:
				spawnert2()
		6:
			spawnert4()
		7:
			for i in 2:
				spawnert3()
		8:
			spawnert5()
		9:
			spawnert2()
			spawnert4()
	if Autoload.levelstate >= 10:
		rand.randomize()
		var number123 = rand.randi_range(1, 6)
		match number123:
			1:
				spawnert3()
				spawnert4()
			2:
				spawnert5()
				spawnert2()
			3:
				spawnert5()
				spawnert5()
			4:
				for i in 3:
					spawnert2()
			5:
				spawnert4()
				for i in 8:
					spawnert1()
			6:
				spawnert4()
				spawnert4()
				
				
				
		pass

###################################

func spawnert1():
	spin.randomize()
	var numb = spin.randi_range(1,2)
	var enemy
	if numb == 1:
		enemy = Autoload.enemiest1[0]
	if numb == 2:
		enemy = Autoload.enemiest1[1]
		#enemy = Autoload.enemiest1[1]
	enemy = load(enemy)
	enemy = enemy.instance()
	#enemy = bigestspider.instance()
	rand.randomize()
	var x = rand.randf_range(0, 250)
	rand.randomize()
	var y = rand.randf_range(70, 200)
	enemy.position.y = y
	enemy.position.x = x
	#enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)
	pass
func spawnert2():
	spin.randomize()
	var numb = spin.randi_range(1,2)
	var enemy
	if numb == 1:
		enemy = Autoload.enemiest2[0]
	if numb == 2:
		enemy = Autoload.enemiest2[1]
	enemy = load(enemy)
	enemy = enemy.instance()
	#enemy = bigestspider.instance()
	rand.randomize()
	var x = rand.randf_range(0, 150)
	rand.randomize()
	var y = rand.randf_range(70, 200)
	enemy.position.y = y
	enemy.position.x = x
	#enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)
func spawnert3():
	spin.randomize()
	var numb = spin.randi_range(1,2)
	var enemy
	if numb== 1:
		enemy = Autoload.enemiest3[0]
	if numb == 2:
		enemy = Autoload.enemiest3[1]
	enemy = load(enemy)
	enemy = enemy.instance()
	#enemy = bigestspider.instance()
	rand.randomize()
	var x = rand.randf_range(0, 250)
	rand.randomize()
	var y = rand.randf_range(70, 200)
	enemy.position.y = y
	enemy.position.x = x
	#enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)
func spawnert4():
	spin.randomize()
	var numb = spin.randi_range(1,2)
	var enemy
	if numb == 1:
		enemy = Autoload.enemiest4[0]
	if numb == 2:
		enemy = Autoload.enemiest4[1]
	enemy = load(enemy)
	enemy = enemy.instance()
	#enemy = bigestspider.instance()
	rand.randomize()
	var x = rand.randf_range(0, 250)
	rand.randomize()
	var y = rand.randf_range(70, 200)
	enemy.position.y = y
	enemy.position.x = x
	#enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)
func spawnert5():
	spin.randomize()
	var numb = spin.randi_range(1,2)
	var enemy
	if numb == 1:
		enemy = Autoload.enemiest5[0]
	if numb == 2:
		enemy = Autoload.enemiest5[1]
	enemy = load(enemy)
	enemy = enemy.instance()
	#enemy = bigestspider.instance()
	rand.randomize()
	var x = rand.randf_range(0, 250)
	rand.randomize()
	var y = rand.randf_range(70, 200)
	enemy.position.y = y
	enemy.position.x = x
	#enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)

######################

func allspawner():
	var rando = RandomNumberGenerator.new()
	rando.randomize()
	rando.randomize()
	var dec = rando.randi_range(1, 5)
	match dec:
		1:
			enemyspawn()
		2:
			enemyspawn()
			#bigspiderpawner()
		3:
			enemyspawn2()
		4:
			enemyspawn3()
		5:
			enemyspawn4()
func boss1pawner():
	var enemy = bigestspider.instance()
	enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)
	
func boss2pawner():
	var enemy = diszno.instance()
	enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)
	
func boss3pawner():
	var enemy = watermage.instance()
	enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)
	
func boss4pawner():
	var enemy = watermage2.instance()
	enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)
	
func miniboss1pawner():
	var enemy = bigspider.instance()
	enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)
	
func enemyspawn():
	var enemy = spider.instance()
	enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)
	spawner()
	
func enemyspawn2():
	var enemy = spider.instance()
	enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)
	#spawner()
	
func enemyspawn3():
	var enemy = spider.instance()
	enemy.start_at($YSort/Position2D.position)
	#$YSort.add_child(enemy)
	spawner()
	
func enemyspawn4():
	var enemy = spider.instance()
	enemy.start_at($YSort/Position2D.position)
	#$YSort.add_child(enemy)
	spawner()
	spawner()
	
func floodspawn():
	var rand = RandomNumberGenerator.new()
	spin.randomize()
	var nu = spin.randi_range(1, 3)
	match nu:
		1:
			var enemy = spider.instance()
			rand.randomize()
			var x = rand.randf_range(0, 250)
			var y = rand.randf_range(70, 200)
			enemy.position.y = y
			enemy.position.x = x								
			#for i in range(4):
			$YSort.add_child(enemy)
		2:
			var enemy = pangulin.instance()
			rand.randomize()
			var x = rand.randf_range(0, 250)
			var y = rand.randf_range(70, 200)
			enemy.position.y = y
			enemy.position.x = x								
			#for i in range(4):
			$YSort.add_child(enemy)
		3:
			for i in range(2):
				var enemy = pangulin.instance()
				rand.randomize()
				var x = rand.randf_range(0, 250)
				var y = rand.randf_range(70, 200)
				enemy.position.y = y
				enemy.position.x = x								
				#for i in range(4):
				$YSort.add_child(enemy)



func spawner():
	var rand = RandomNumberGenerator.new()
	#var enemy = spider.instance()
									#var room = rooms[1 + randi() % (rooms.size() - 1)]
	for i in range(2):
		var enemy = pangulin.instance()
		rand.randomize()
		var x = rand.randf_range(0, 250)
		var y = rand.randf_range(70, 200)
		enemy.position.y = y
		enemy.position.x = x								
		#for i in range(4):
		$YSort.add_child(enemy)
		i += 1

func addbossloot():
	Autoload.zsakmany.shuffle()
	Autoload.loottable.append(Autoload.zsakmany[0])
	
func addboss2loot():
	Autoload.bosszsakmany.shuffle()
	Autoload.loottable.append(Autoload.bosszsakmany[0])
	
func addboss3loot():
	Autoload.rarezsakmany.shuffle()
	Autoload.loottable.append(Autoload.rarezsakmany[0])

func _process(delta):
	#wakei()
	if $Camera2D.current == true:
		$Button2.show()
	else:
		$Button2.hide()
	Autoload.bosszsakmany.shuffle()
	Autoload.zsakmany.shuffle()
	if gamestate == "loot" or loopin == true:
		pass
		#$inventory2add.visible = true
	else:
		$inventory2add.visible = false
	


func _on_Button_pressed():
	if pressed == false:
		gamestate = "combat"
		allspawner()
		#enemyspawn()
		#enemyspawn()
		#pressed = true
		$Button.hide()
		$summonboss.hide()
		$summonfinalboss.hide()
		#$Button.queue_free()
		$loopbutton.hide()

func _on_Button2_pressed():
	get_tree().change_scene("res://misc/loottable.tscn")
	#get_tree().change_scene("res://misc/terkep.tscn")
	#Autoload.loottable.clear()
	#Autoload.levelstate -= 1
	#get_tree().change_scene("res://inventory/inventory/invman.tscn")
	#get_tree().change_scene("res://menu.tscn")



func _on_inventory2add_pressed():
	get_tree().change_scene("res://misc/loottable.tscn")
	#pass # Replace with function body.


func _on_stateswapper_body_entered(body):
	enemieslist.append(body)
	gamestate = "combat"

func _on_stateswapper_body_exited(body):
	enemieslist.erase(body)
	szamol = len(enemieslist)
	if szamol == 0 and gamestate == "combat" and loopin == false:
		gamestate = "loot"
			
		#if player != null:
		#	player.sleep()
		#	$Camera2D.current = true
		#pressed = false
		spin.randomize()
		spin.randomize()
		var ex = spin.randi_range(1, 100)
		if Autoload.levelstate == 1:
			for i in 3:
				addbossloot()
			#for i in 10:
			#	addboss3loot()
			if ex > (90):
				addboss2loot()
		spin.randomize()
		ex = spin.randi_range(1, 100)
		if Autoload.levelstate == 2:
			for i in 4:
				addbossloot()
			if ex > (80):
				addboss2loot()
		if Autoload.levelstate == 3 :
			for i in 2:
				addboss2loot()
			if ex > (80):
				addboss3loot()
		if Autoload.levelstate == 4:
			for i in 3:
				addboss2loot()
			if ex > (50):
				addboss3loot()
			pass
		if Autoload.levelstate >= 5:
			#addboss3loot()
			for i in 2:
				addboss2loot()
			if ex > (50):
				addboss3loot()
		if Autoload.levelstate >= 8:
			addboss3loot()
			
			pass
		$door/CollisionShape2D.disabled = false
		$Sprite7.frame = 1
		$KinematicBody2D7/CollisionShape2D.disabled = false
		#get_tree().change_scene("res://misc/dungeonchooser.tscn")
			#for i in 4:
			#	addbossloot()
		#$summonboss.show()
		#if Autoload.levelstate < 6:
			#Autoload.levelstate += 1
		#if ex > (100-Autoload.levelstate):
		#	addboss3loot()
		#elif ex >

func _on_stateswapper2_body_entered(body):
	allylist.append(body)
	#gamestate = "combat"

func _on_stateswapper2_body_exited(body):
	allylist.erase(body)
	var szamol2 = len(allylist)
	if szamol2 == 0 and gamestate == "combat":
		#get_tree().change_scene("res://misc/loottable.tscn")
		gamestate = "loose"#"loot"
		#if Autoload.levelstate >1:
		#	Autoload.levelstate -= 1
		#Autoload.loottable.clear()
		pass
		#$Button.show()
		#pressed = false
func starttheround():
	var led = len(dummies)
	if led > 0:
		for i in led:
			var dummie = dummies[i]
			dummie.wakeup()

func _on_summonboss_pressed():
	starttheround()
	wakeiwakei = true
	$summonboss.hide()#.queue_free()
	
func wakei():
	if wakeiwakei == true:
		starttheround()
		#pass
	
	

func _on_summonfinalboss_pressed():
	pass

func _on_loopbutton_pressed():
	pass



func _on_Area2D2_body_entered(body):
	if body.has_method("wakeup"):
		dummies.append(body)
		wakei()
	if body.has_method("sleep"):
		player = body
	#pass # Replace with function body.


func _on_Area2D2_body_exited(body):
	dummies.erase(body)
	if body.has_method("sleep"):
		body.sleep()
		$Camera2D.current = true
		player = null
	pass # Replace with function body.


func _on_Timer_timeout():
	floodspawn()
	floodcounter -= 1
	loopin = true
	if floodcounter <= 0:
		$Timer.stop()
		loopin = false
	#pass # Replace with function body.


func _on_door_body_entered(body):
	Autoload.levelstate += 1
	get_tree().change_scene("res://maps/map5.tscn")
	#get_tree().change_scene("res://misc/dungeonchooser2.tscn")
