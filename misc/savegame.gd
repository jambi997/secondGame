extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#const score_file = preload('res://misc/saveiour.gd')

var score_file = "user://score.save1"
#var score_file = "user://test.txt"
var inv1 = Autoload.invwep #'preload("res://weapons/sword2.tscn") '
var inv2 = Autoload.szekreny
var inv3 = Autoload.invarm
var inv4 = Autoload.postomb


func save_score():
	var file = File.new()
	file.open(score_file, File.WRITE)
	file.store_var(inv1)
	file.store_var(inv2)
	file.store_var(inv3)
	file.store_var(inv4)
	file.close()
#	pass

func load_score():
	var file = File.new()
	if file.file_exists(score_file):
		file.open(score_file, File.READ)
		inv1 = file.get_var()
		inv2 = file.get_var()
		inv3 = file.get_var()
		inv4 = file.get_var()
		file.close()
	else:
		pass
		#inv1 = 0

func _process(delta):
	pass
	$Label.text = str(Autoload.invwep)  


func _on_Button_pressed():
	save_score()


func _on_Button2_pressed():
	load_score()
	Autoload.invwep = inv1
	Autoload.szekreny = inv2
	Autoload.invarm = inv3
	Autoload.postomb = inv4
	
func _on_Button3_pressed():
	pass
	#highscore = "kézigránát"
