extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dragging = true
var mousepos
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if dragging:
		mousepos = get_global_mouse_position()
		#position = Vector2(mousepos.x, mousepos.y)
		position.x = mousepos.x
		position.y = mousepos.y
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
