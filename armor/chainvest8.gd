extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var armor = 10
var hpbonus = 800
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent().get_parent().get_parent()
	if parent.has_method("addhp"):
		parent.addhp(hpbonus)
		parent.scale.x = 1.1
		parent.scale.y = 1.1
	#if parent.has_method("shield"):
	#	parent.shield(100)
	if parent.has_method("danger"):
		parent.danger(500)
	if parent.has_method("addattackspeed"):
		parent.addattackspeed(2)
		#parent.global_position.x = parent.global_position.x * -1
	#	parent.speedset(-20)
	#if parent.has_method("addattackspeed"):
	#	parent.addattackspeed(-0.2)
	#pass # Replace with function body.

func _process(delta):
	if parent.has_method("danger"):
		parent.danger(10)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





