extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var spin = RandomNumberGenerator.new()
var numbi = 4
# Called when the node enters the scene tree for the first time.

func _ready():
	var spin = RandomNumberGenerator.new()
	spin.randomize()
	var spinning = spin.randi_range(4,6)
	numbi = spinning
	if Autoload.levelstate > 1 : #and numbi == 4:
		$adventure3.show()
#	if Autoload.levelstate > 3 : #and numbi == 4:
#		$adventure6.show()
	#$adventure3.text = "this path leads to a large spider"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://inventory/inventory/invman.tscn")
	Autoload.nextroom = "res://maps/map1.tscn"
	
	


func _on_second_area_pressed():
	get_tree().change_scene("res://inventory/inventory/invman.tscn")
	Autoload.nextroom = "res://maps/map2.tscn"

func cl1():
	Autoload.levelstate = 1

func _on_adventure_pressed():
	#get_tree().change_scene("res://inventory/inventory/invman.tscn")
	Autoload.levelstate = 1
	Autoload.nextroom = "res://maps/map5.tscn"
	get_tree().change_scene(Autoload.nextroom)


func _on_adventure2_pressed():
	Autoload.levelstate = 1
	Autoload.nextroom = "res://maps/map5.tscn"
	get_tree().change_scene(Autoload.nextroom)


func _on_adventure3_pressed():
	Autoload.levelstate = 2
	Autoload.nextroom = "res://maps/map5.tscn"
	get_tree().change_scene(Autoload.nextroom)


func _on_adventure4_pressed():
	get_tree().change_scene("res://misc/loottable.tscn")


func _on_adventure5_pressed():
	Autoload.levelstate = numbi
	Autoload.nextroom = "res://maps/map5.tscn"
	get_tree().change_scene(Autoload.nextroom)


func _on_adventure6_pressed():
	Autoload.levelstate = 7
	Autoload.nextroom = "res://maps/map5.tscn"
	get_tree().change_scene(Autoload.nextroom)
