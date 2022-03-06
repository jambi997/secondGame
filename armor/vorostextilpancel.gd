extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var armor = 15
var hpbonus = 10
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent().get_parent().get_parent()
	if parent.has_method("addhp"):
		parent.addhp(hpbonus)
	#if parent.has_method("shield"):
	#	parent.shield(100)
	if parent.has_method("danger"):
		parent.danger(-100)
	if parent.has_method("addattackspeed"):
		parent.addattackspeed(0.9)
		parent.speedset(10)
	#if parent.has_method("addattackspeed"):
	#	parent.addattackspeed(-0.2)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





