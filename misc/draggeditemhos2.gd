extends KinematicBody2D

var dragging = false

signal dragsignal;
var droppable = false
var parent
const human =  preload("res://characters/human3player.tscn")
var fegy
var panc

export (int) var id = 1

func _ready():
	connect("dragsignal",self,"_set_drag_pc")
	parent = get_parent()
	choosegear()
	var ember = human.instance()
	var fegyo = load(fegy).instance()
	var panco = load(panc).instance()
	$Sprite3.texture = fegyo.texture
	$Sprite4.texture = fegyo.texture
	$Sprite2.texture = panco.texture
	$Sprite3.modulate = fegyo.modulate
	$Sprite2.modulate= panco.modulate


func start_at(pos ,dir):
	position = pos
	rotation = dir
	pause_mode = Node.PAUSE_MODE_PROCESS
	
func _process(delta):
 
	if dragging:
		var mousepos = get_global_mouse_position()
		self.global_position = Vector2(mousepos.x, mousepos.y)

func choosegear():
	match id:
		0:
			fegy = Autoload.wep
			panc = Autoload.ruha
		1:
			fegy = Autoload.wep1
			panc = Autoload.ruha1
		2:
			fegy = Autoload.wep2
			panc = Autoload.ruha2
		3:
			fegy = Autoload.wep3
			panc = Autoload.ruha3
		4:
			fegy = Autoload.wep4
			panc = Autoload.ruha4
			
			
		
func dropped():
	var droplet = human.instance()
	droplet.start_at(position)
	#droplet.id = id
	parent.add_child(droplet)
	#droplet.id = id
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


#func gear():
#	match id:
		


func _on_Area2D_area_entered(area):
	if area.is_in_group("dropheroes"):
		droppable = true


func _on_Area2D_area_exited(area):
	droppable = false
