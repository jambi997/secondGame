extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const human3 = preload("res://characters/human3.tscn")

var dragging = false

signal dragsignal;

func _ready():
	connect("dragsignal",self,"_set_drag_pc")
	
func _process(delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)


func _set_drag_pc():
	dragging=!dragging

func dropped():
	var dropp = human3.instance
	add_child(dropp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("dragsignal")
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			emit_signal("dragsignal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()


func _on_Kin_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
