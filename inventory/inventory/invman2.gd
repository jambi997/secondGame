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

var vl = false
#onready var posic = get_node($Node2D/Position2D)
# Called when the node enters the scene tree for the first time.
func _ready():
	#setid()
	posc = get_node(posc2)
	itemdobalo()
	#ressett()
	if vl == true:
		visible = true
	elif vl == false:
		visible = false
	
	#listinv()
	
	pass # Replace with function body.

func itemdobalo():
	var cont = len(Autoload.szekreny)
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
	get_tree().change_scene("res://maps/map1.tscn")







	#numb = 14


func _on_TextureButton_pressed():
	vl = false
	visible = false
	#queue_free()
