extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text
export (int) var id = 0
var fegyverid = 0
var fegyver = "res://weapons/axe1.tscn" 
var armor = "res://armor/chainvest.tscn"
var fe3 #= Autoload.invwep[id]
var iv = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#setproc()
	#if Autoload.invwep[id] != null:
	fe3 = Autoload.invwep[id]
	var fe4 = load(fe3)
	fe4 = fe4.instance()

		#pass
	add_child(fe4)
	fe4.get_node("Area2D/CollisionShape2D").disabled = true
	fegyver = fe4.fegyver
	#pass # Replace with function body.

func fegycsere(fe , fe2):
	#Autoload.szekreny.()
	if fe3 != null:
		Autoload.szekreny.append(fe3)
	fegyver = fe
	Autoload.invwep.remove(id)
	Autoload.invwep.insert(id, fe2) #= fe2
	fe3 = fe2
	Autoload.szekreny.erase(fe3)
	Autoload.szekreny.sort()

func fegyo():
	match id:
		0:
			Autoload.wep = fegyver
		1:
			Autoload.wep1 = fegyver
		2:
			Autoload.wep2 = fegyver
		3:
			Autoload.wep3 = fegyver
		4:
			Autoload.wep4 = fegyver

func armory():
	match id:
		0:
			Autoload.ruha = armor
		1:
			Autoload.ruha1 = armor
		2:
			Autoload.ruha2 = armor
		3:
			Autoload.ruha3 = armor
		4:
			Autoload.ruha4 = armor

func setproc():
	if visible == false:
		set_process(false)
	elif visible == true:
		set_process(true)
	#pass
	
func _process(delta):
	#setproc()
	#pass
	fegyo()
	#armory()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
