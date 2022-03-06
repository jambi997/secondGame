extends KinematicBody2D

var dragging = false

signal dragsignal;
var droppable = false
var parent
var armor = "res://armor/vorostextilpancel4.tscn"
var inventory
#const itself = self #preload("res://inventory/draggeditemteszt.tscn")
export (int) var rarity = 3
export (int) var id = 3
#var parentem 
var itself = "res://inventory/armorinvs/armoritem10.tscn"

var text

func _ready():
	connect("dragsignal",self,"_set_drag_pc")
	gogetdaddy()
	#parent = get_parent()
	var fegyver2 = load(armor).instance()
	$Sprite2.texture = fegyver2.texture
	$Sprite2.modulate = fegyver2.modulate
	rrarity()
	settext()
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
			$Sprite.modulate = Color("#4f5252")
		2:
			$Sprite.modulate = Color("#36801b")
		3:
			$Sprite.modulate = Color("#13126f")
		4:
			$Sprite.modulate = Color("#3b0060")
		5:
			$Sprite.modulate = Color("#d2c23c")
	
func start_at(pos ):
	global_position = pos

	
func _process(delta):
 
	if dragging:
		#var mousepos = get_global_mouse_position()
		#self.position = Vector2(mousepos.x, mousepos.y)
		global_position = get_global_mouse_position()


		

func setitem():
	inventory.armorcsere(armor, itself)
	
	#inventory.fegyverid = id
	#inventory.fegyver = fegyver
	#inventory.add_child(self)
	#call_deferred("reparent",self)
	#pass
	#call_deferred("reparent3",inventory)
	reparent3(inventory)

func _set_drag_pc():
	dragging=!dragging


		
		
func settext():
	text = "armor = 15% \nlowers attack speed 60%\nboosts movement speed "
	$Node2D/RichTextLabel.text = text
	



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
				#dropped()
				

			#showtext()
				
				
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()



func reparent3(partner):
	var post = global_position
	var sel = self
	start_at(post)
	get_parent().call_deferred("remove_child", sel)
	#get_parent().remove_child(sel)
	start_at(post)
	#sel.start_at(post)
	global_position = post
	partner.call_deferred("add_child", sel)
	#partner.add_child(sel)
	#partner.move_child(self, position)
	global_position = post



func _on_Area2D_area_entered(area):
	if area.is_in_group("armorarea"):
		droppable = true
		inventory = area.get_parent()


func _on_Area2D_area_exited(area):
	if area.is_in_group("armorarea"):
		droppable = false
		#if inventory == area:
		inventory = null
		#call_deferred("reparent3",parent)
		reparent3(parent)
		#call_deferred("reparent2",self)


func _on_Area2D_mouse_entered():
	$Node2D/RichTextLabel.visible = true


func _on_Area2D_mouse_exited():
	$Node2D/RichTextLabel.visible = false
	#showtext()
