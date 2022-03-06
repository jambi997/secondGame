extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var kid = get_child(0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass











func _on_Button_toggled(button_pressed):
	if kid.has_method("pauseing"):
		kid.pauseing(false)
	


func _on_Button2_toggled(button_pressed):
	if kid.has_method("pauseing"):
		kid.pauseing(true)
