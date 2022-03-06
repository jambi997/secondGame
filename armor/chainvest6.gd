extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var armor = 20
var hpbonus = 100
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent().get_parent().get_parent()
	if parent.has_method("addhp"):
		parent.addhp(hpbonus)
	#if parent.has_method("shield"):
	#	parent.shield(100)
	if parent.has_method("danger"):
		parent.danger(300)
	if parent.has_method("addattackspeed"):
		parent.addattackspeed(0.9)
		#parent.modulate.a8 = 70
		#parent.speedset(30)
	#if parent.has_method("addattackspeed"):
	#	parent.addattackspeed(-0.2)
	#pass # Replace with function body.

func _process(delta):
	pass
	
	#if parent.has_method("danger"):
	#	parent.danger(-100)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass







func _on_Area2D_body_entered(body):
	if body.has_method("addattackspeed"):
		body.addattackspeed(0.8)


func _on_Area2D_body_exited(body):
	if body.has_method("addattackspeed"):
		body.addattackspeed(1.25)
