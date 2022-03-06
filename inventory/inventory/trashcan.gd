extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	#$Area2D/CollisionShape2D.disabled = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	#if area.has.get_parent().istelf:
	var ri = area.get_parent().itself
	var rin = area.get_parent()
	if ri in Autoload.szekreny and rin.dragging != false : #and rin not dragging :
		Autoload.szekreny.erase(ri)
		if parent.has_method("resetscene"):
			parent.resetscene()


func _on_Button_pressed():
	$Area2D/CollisionShape2D.disabled = false
	$Button.visible = false
	#pass # Replace with function body.
