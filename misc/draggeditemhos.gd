extends KinematicBody2D

var dragging = false

signal dragsignal;
var droppable = false
var parent
const human =  preload("res://characters/human.tscn")



func _ready():
	connect("dragsignal",self,"_set_drag_pc")
	parent = get_parent()
	
func start_at(pos ,dir):
	position = pos
	rotation = dir
	pause_mode = Node.PAUSE_MODE_PROCESS
	
func _process(delta):
 
	if dragging:
		var mousepos = get_global_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)



		
func dropped():
	var droplet = human.instance()
	droplet.start_at(position)
	parent.add_child(droplet)
	queue_free()

func _set_drag_pc():
	dragging=!dragging


func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("dragsignal")
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			emit_signal("dragsignal")
			if droppable == true:
				#pass
				dropped()
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()





func _on_Area2D_area_entered(area):
	if area.is_in_group("dropheroes"):
		droppable = true


func _on_Area2D_area_exited(area):
	droppable = false
