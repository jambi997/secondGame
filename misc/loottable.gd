extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var item
var numb = Autoload.numb
var posc
var number
var posc2 = "Sprite/Position2D1"
var limit = 96
var cont = len(Autoload.loottable)
# Called when the node enters the scene tree for the first time.
func _ready():
	posc = get_node(posc2)
	var cont = len(Autoload.loottable)
	if cont > 0:
		itemdobalo()
	
	#pass # Replace with function body.


func itemdobalo():
	cont = len(Autoload.loottable)
	if cont > limit:
		#pass
		cont = limit
	
	for i in cont:
		listinv()
		numb += 1
		number = numb +1
		posc2 = "Sprite/Position2D" + str(number)
		posc = get_node(posc2)
		#posc = get_node("Node2D/Posi

func listinv():
	#Autoload.szekreny[0].instance().start_at($Node2D/Position2D)
	#.start_at($Node2D/Position2D.position)
	#Autoload.szekreny[0].instance().start_at($Node2D/Position2D.position)
	item = Autoload.loottable[numb]#.instance()
	item = load(item)
	item = item.instance()
	item.start_at(posc.global_position)
	#posc.foglalt = true
	$Node.add_child(item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	Autoload.loottable.clear()
	get_tree().change_scene("res://inventory/inventory/invman.tscn")#(Autoload.nextroom)
	#pass # Replace with function body.


func _on_Button2_pressed():
	for i in cont:
		var rite = Autoload.loottable[i]
		Autoload.szekreny.append(rite)
		#Autoload.loottable.erase(rite)
		i += 1
		#Autoload.loottable[i]
	Autoload.loottable.clear()
	get_tree().change_scene("res://inventory/inventory/invman.tscn")
	
	
	
	pass


func _on_Button3_pressed():
	cont = len(Autoload.loottable)
	for i in cont:
		var rite = Autoload.loottable[i]
		var rite2 = load(rite)
		var rite3 = rite2.instance()
		if rite3.rarity > 1:
			Autoload.szekreny.append(rite)
		#Autoload.loottable.erase(rite)
		i += 1
		#Autoload.loottable[i]
	Autoload.loottable.clear()
	get_tree().change_scene("res://inventory/inventory/invman.tscn")


func _on_Button4_pressed():
	cont = len(Autoload.loottable)
	for i in cont:
		var rite = Autoload.loottable[i]
		var rite2 = load(rite)
		var rite3 = rite2.instance()
		if rite3.rarity > 2:
			Autoload.szekreny.append(rite)
		#Autoload.loottable.erase(rite)
		i += 1
		#Autoload.loottable[i]
	Autoload.loottable.clear()
	get_tree().change_scene("res://inventory/inventory/invman.tscn")
