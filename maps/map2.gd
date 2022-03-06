extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var wcount =  250
const human = preload("res://characters/human.tscn")
const human2 = preload("res://characters/human4.tscn")
const human3 = preload("res://characters/human3.tscn")
const diszno = preload("res://monsters/boar3.tscn")
const spider = preload("res://monsters/spider.tscn")
const bigspider = preload("res://monsters/bigspider.tscn")
const bigestspider = preload("res://monsters/boar3.tscn")
const pangulin = preload("res://monsters/pangulin.tscn")
var enemieslist = []
var allylist = []
var gamestate = "placing"
var szamol
var pressed = false
var mausepos
var spin = RandomNumberGenerator.new()
var loopin = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#spawner()
	#mobspawner()
	#mobspawner()
	#mobspawner()
	#mobspawner()
	#enemyspawn()
	

	
	
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
func bigerspiderpawner():
	var enemy = bigestspider.instance()
	enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)

func bigspiderpawner():
	var enemy = bigspider.instance()
	enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)
	
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
	
func enemyspawn():
	var enemy = spider.instance()
	enemy.start_at($YSort/Position2D.position)
	$YSort.add_child(enemy)
	spawner()
	

func spawner():
	var rand = RandomNumberGenerator.new()
	#var enemy = spider.instance()
									#var room = rooms[1 + randi() % (rooms.size() - 1)]
	for i in range(2):
		var enemy = pangulin.instance()
		rand.randomize()
		var x = rand.randf_range(0, 250)
		var y = rand.randf_range(0, 100)
		enemy.position.y = y
		enemy.position.x = x								
		#for i in range(4):
		$YSort.add_child(enemy)
		i += 1

func addbossloot():
	Autoload.bosszsakmany.shuffle()
	Autoload.loottable.append(Autoload.bosszsakmany[0])

func _process(delta):
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
		pressed = true
		$Button.hide()
		$summonboss.hide()
		$summonfinalboss.hide()
		#$Button.queue_free()
		$loopbutton.hide()

func _on_Button2_pressed():
	get_tree().change_scene("res://inventory/inventory/invman.tscn")
	#get_tree().change_scene("res://menu.tscn")



func _on_inventory2add_pressed():
	get_tree().change_scene("res://misc/loottable.tscn")
	#pass # Replace with function body.


func _on_stateswapper_body_entered(body):
	enemieslist.append(body)


func _on_stateswapper_body_exited(body):
	enemieslist.erase(body)
	szamol = len(enemieslist)
	if szamol == 0 and gamestate == "combat":
		gamestate = "loot"
		var cont = len(Autoload.loottable)
		if cont < 25 and loopin == false:
			
			$summonfinalboss.show()
			$summonboss.show()
			$Button.show()
			$loopbutton.show()
		if cont < 25 and loopin == true:
			gamestate = "combat"
			allspawner()
			
		pressed = false
		spin.randomize()
		var ex = spin.randi_range(1, 100)
		if ex > 80:
			addbossloot()

func _on_stateswapper2_body_entered(body):
	allylist.append(body)


func _on_stateswapper2_body_exited(body):
	allylist.erase(body)
	var szamol2 = len(allylist)
	if szamol2 == 0 and gamestate == "combat":
		gamestate = "loot"
		#$Button.show()
		#pressed = false


func _on_summonboss_pressed():
	bigspiderpawner()
	gamestate = "combat"
	$summonfinalboss.hide()
	$Button.hide()
	#pressed = true
	$summonboss.hide()
	#pass # Replace with function body.
	$loopbutton.hide()

func _on_summonfinalboss_pressed():
	bigerspiderpawner()
	gamestate = "combat"
	$summonfinalboss.hide()
	
	$Button.hide()
	#pressed = true
	$summonboss.hide()
	$loopbutton.hide()

func _on_loopbutton_pressed():
	allspawner()
	loopin = true
	gamestate = "combat"
	$summonfinalboss.hide()
	$Button.hide()
	#pressed = true
	$summonboss.hide()
	$loopbutton.hide()

