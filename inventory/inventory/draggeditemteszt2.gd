extends KinematicBody2D

var dragging = false

signal dragsignal;
var droppable = false
var parent
const human =  preload("res://characters/human3.tscn")
var fegyver = preload("res://weapons/sword2.tscn") 
var inventory
#const itself = self #preload("res://inventory/draggeditemteszt.tscn")
export (int) var rarity = 1
export (int) var id = 3
#var parentem 
var itself = load("res://inventory/inventory/draggeditemteszt2.tscn")


func _ready():
	connect("dragsignal",self,"_set_drag_pc")
	gogetdaddy()
	#parent = get_parent()
	var fegyver2 = fegyver.instance()
	$Sprite2.texture = fegyver2.texture
	rrarity()
	
	#add_child(fegyver2)
	
func gogetdaddy():
	var pari = get_parent()
	if pari.is_in_group("invent"):
		parent = get_parent()
	elif pari.get_parent().is_in_group("invent"):
		parent = get_parent().get_parent() #.getparent()
	
func rrarity():
	match rarity:
		1:
			$Sprite.modulate = Color("#8b8b7c")
	
func start_at(pos ):
	global_position = pos

	
func _process(delta):
 
	if dragging:
		#var mousepos = get_global_mouse_position()
		#self.position = Vector2(mousepos.x, mousepos.y)
		global_position = get_global_mouse_position()


		
func dropped():
	var droplet = human.instance()
	droplet.start_at(position)
	droplet.id = id
	parent.add_child(droplet)
	droplet.id = id
	queue_free()

func setitem():
	inventory.fegycsere(fegyver, itself)
	
	#inventory.fegyverid = id
	#inventory.fegyver = fegyver
	#inventory.add_child(self)
	#call_deferred("reparent",self)
	#pass
	#call_deferred("reparent3",inventory)
	reparent3(inventory)

func _set_drag_pc():
	dragging=!dragging


func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("dragsignal")
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			emit_signal("dragsignal")
			if droppable == true:
				setitem()
				if parent.has_method("resetscene"):
					parent.resetscene()
				#pass
				#dropped()
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()

func reparent(node, panter):
	node.get_parent().remove_child(node) # error here  
	panter.add_child(node) 

func reparent3(partner):
	var post = global_position
	var sel = self
	start_at(post)
	get_parent().call_deferred("remove_child", sel)
	#get_parent().remove_child(sel)
	start_at(post)
	#sel.start_at(post)
	#global_position = post
	partner.call_deferred("add_child", sel)
	#partner.add_child(sel)
	#partner.move_child(self, position)
	global_position = post

func reparent2(node):
	node.get_parent().remove_child(node) # error here  
	parent.add_child(node) 

func _on_Area2D_area_entered(area):
	if area.is_in_group("fegyverarea"):
		droppable = true
		inventory = area.get_parent()


func _on_Area2D_area_exited(area):
	if area.is_in_group("fegyverarea"):
		droppable = false
		#if inventory == area:
		inventory = null
		#call_deferred("reparent3",parent)
		reparent3(parent)
		#call_deferred("reparent2",self)
