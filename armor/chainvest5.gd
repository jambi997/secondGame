extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var armor = 10
var hpbonus = 0
var parent
var healtarget = null
var targets = []
var heal = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent().get_parent().get_parent()
	if parent.has_method("addhp"):
		parent.addhp(hpbonus)
	#if parent.has_method("shield"):
	#	parent.shield(100)
	if parent.has_method("danger"):
		parent.danger(-2000)
	if parent.has_method("addattackspeed"):
	#	parent.addattackspeed(0.6)
		parent.modulate.a8 = 70
		#parent.global_position.x = parent.global_position.x * -1
		#parent.speedset(30)
	#if parent.has_method("addattackspeed"):
	#	parent.addattackspeed(-0.2)
	#pass # Replace with function body.

func _process(delta):
	if parent.has_method("danger"):
		parent.danger(-100)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


	
	
