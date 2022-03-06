extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
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
	Autoload.nextdung = "res://misc/dungeonchooser.tscn"

func _on_adventure_pressed():
	Autoload.levelstate = 1
	get_tree().change_scene("res://inventory/inventory/invman.tscn")
	#Autoload.nextdung = "res://misc/dungeonchooser.tscn"
	Autoload.nextdung = "res://maps/map4.tscn"
	#get_tree().change_scene(Autoload.nextroom)


func _on_adventure2_pressed():
	Autoload.levelstate = 1
	get_tree().change_scene("res://inventory/inventory/invman.tscn")
	#Autoload.nextdung = "res://misc/dungeonchooser2.tscn"
	Autoload.nextdung = "res://maps/map5.tscn"


func _on_Button2_pressed():
	get_tree().change_scene("res://maps/map45savepos.tscn")
	pass # Replace with function body.
