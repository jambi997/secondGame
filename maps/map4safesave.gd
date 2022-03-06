extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var wcount =  250
const diszno = preload("res://monsters/boar3.tscn")
const spider = preload("res://monsters/spider.tscn")
const bigspider = preload("res://monsters/bigspider.tscn")
const bigestspider = preload("res://monsters/bigestspider.tscn")
const pangulin = preload("res://monsters/pangulin.tscn")
const turtle = preload("res://monsters/turtle.tscn")
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
# Called when the node enters the scene tree for the first time.
func _ready():
	spin.randomize()
	chooseroom()
	colorbackground()
	#gamestate = "combat"
	
	#pass # Replace with function body.
	#spawner()
	#mobspawner()
	#mobspawner()
	#mobspawner()
	#mobspawner()
	#enemyspawn()
	
func placeallies():
	var rand = RandomNumberGenerator.new()
	#var enemy = spider.instance()
									#var room = rooms[1 + randi() % (rooms.size() - 1)]
	for i in range(4):
		var enemy = allies.instance()
		rand.randomize()
		var x = rand.randf_range(-200, -320)
		var y = rand.randf_range(70, 200)
		enemy.position.y = y
		enemy.position.x = x								
		enemy.id = i
		#for i in range(4):
		$YSort.add_child(enemy)
		i += 1
		
		
		
		
	
func colorbackground():
	var randomgen = RandomNumberGenerator.new()
	randomgen.randomize()
	var rrr = randomgen.randi_range(1, 4)
	match rrr:
		1:
			$Sprite.self_modulate = Color("#3e4040")
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
			acroom = allspawner()
			pass
		2:
			acroom = allspawner()
			pass
		3:
			acroom = miniboss1pawner()
			pass
		4:
			acroom = boss1pawner()
		5:
			acroom = boss2pawner()
		6:
			acroom = boss3pawner()
		7:
			pass

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
	var enemy = turtle.instance()
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
	Autoload.bosszsakmany.shuffle()
	Autoload.zsakmany.shuffle()
	if gamestate == "loot" or loopin == true:
		$inventory2add.visible = true
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
	#get_tree().change_scene("res://misc/terkep.tscn")
	Autoload.loottable.clear()
	Autoload.levelstate -= 1
	get_tree().change_scene("res://inventory/inventory/invman.tscn")
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
	if szamol == 0 and gamestate == "combat":
		gamestate = "loot"
			
		if player != null:
			player.sleep()
			$Camera2D.current = true
		#pressed = false
		spin.randomize()
		spin.randomize()
		var ex = spin.randi_range(1, 100)
		for i in Autoload.levelstate + 3:
			addbossloot()
		if ex > (90-(Autoload.levelstate*10)):
			addboss2loot()
		if Autoload.levelstate == 3:
			addboss2loot()
			addboss2loot()
		if Autoload.levelstate >= 5 and ex > 80 :
			addboss3loot()
		if Autoload.levelstate == 6:
			addboss3loot()
		if Autoload.levelstate >= 5:
			for i in 3:
				addboss2loot()
			#for i in 4:
			#	addbossloot()
		#$summonboss.show()
		#if Autoload.levelstate < 6:
		#	Autoload.levelstate += 1
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
		#gamestate = "loose"#"loot"
		#if Autoload.levelstate >1:
		#	Autoload.levelstate -= 1
		Autoload.loottable.clear()
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
