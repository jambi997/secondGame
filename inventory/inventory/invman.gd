extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var numb = Autoload.numb
var posc
var item
var cont = len(Autoload.szekreny)
var posc2 = "Node2D/Position2D1"
var number = numb +1

#onready var posic = get_node($Node2D/Position2D)
# Called when the node enters the scene tree for the first time.
func _ready():
	#setid()
	posc = get_node(posc2)
	itemdobalo()
	gibetext2()
	#ressett()
	#$Label.text = "asdasdas"
	#listinv()
	
	pass # Replace with function body.

func itemdobalo():
	cont = len(Autoload.szekreny)
	if cont > Autoload.invlimit:
		#pass
		cont = Autoload.invlimit
	
	for i in cont:
		listinv()
		numb += 1
		number = numb +1
		posc2 = "Node2D/Position2D" + str(number)
		posc = get_node(posc2)
		#posc = get_node("Node2D/Position2D2")

func gibetext():
	var fe3 = Autoload.invwep[0]
	fe3 = load(fe3)
	fe3 = fe3.instance()
	fe3.settext()
	#var fe4 = fe3.get_child($Node2D).get_child($RichTextLabel)
	$Label.text = fe3.text
	
func gibetext2():
	for i in range (1, 11):
		var fe3
		if i <= 5:
			fe3 = Autoload.invwep[i-1]
		elif i > 5:
			fe3 = Autoload.invarm[i-6]
		fe3 = load(fe3)
		fe3 = fe3.instance()
		fe3.settext()
		#var fe4 = fe3.get_child($Node2D).get_child($RichTextLabel)
		var textil = "Label" + str(i)
		textil = get_node(textil)
		textil.text = fe3.text
		i += 1
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func listinv():
	#Autoload.szekreny[0].instance().start_at($Node2D/Position2D)
	#.start_at($Node2D/Position2D.position)
	#Autoload.szekreny[0].instance().start_at($Node2D/Position2D.position)
	item = Autoload.szekreny[numb]#.instance()
	item = load(item)
	item = item.instance()
	item.start_at(posc.global_position)
	posc.foglalt = true
	$Node.add_child(item)
	#posc = get_node("Node2D/Position2D"numb)
	#$Node.add_child(Autoload.szekreny[0].instance())
	
	#pass
func _process(delta):
	visiblity()

func visiblity():
	$inventory.visible = Autoload.v1
	$inventory2.visible = Autoload.v2
	$inventory3.visible = Autoload.v3
	$inventory4.visible = Autoload.v4
	$inventory5.visible = Autoload.v5
	






func ressett():
	Autoload.v1 = false
	Autoload.v2 = false
	Autoload.v3 = false
	Autoload.v4 = false
	Autoload.v5 = false
	
	
func setid():
	$inventory.id = 0
	$inventory.id = 1
	
func resetscene():
	get_tree().reload_current_scene()
	
	
func _on_Button_pressed():
	Autoload.levelstate = 1
	get_tree().change_scene(Autoload.nextdung)
	#get_tree().change_scene(Autoload.nextroom)






func _on_char1_pressed():
	ressett()
	Autoload.v1 = true
	get_tree().reload_current_scene()
	$inventory.set_process(true)
	#get_tree().reload_node($Node2D)
	#$inventory.id = 0

	#get_tree().reload_current_scene()
	
	#pass # Replace with function body.


func _on_char2_pressed():
	ressett()
	Autoload.v2 = true
	$inventory2.set_process(true)
	get_tree().reload_current_scene()
	#$inventory.id = 1

	#get_tree().reload_current_scene() # Replace with function body.


func _on_Button2_pressed():
	Autoload.numb = 0
	get_tree().reload_current_scene()
	

func _on_Button3_pressed():
	if cont > 14:
		Autoload.numb = 15
		get_tree().reload_current_scene()
	#numb = 14


func _on_exit_pressed():
	get_tree().change_scene("res://menu.tscn")


func _on_Button4_pressed():
	get_tree().change_scene("res://misc/terkep.tscn")


func _on_Button5_pressed():
	get_tree().change_scene("res://maps/map45savepos.tscn")
