extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var armor = 10
var hpbonus = 0
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent().get_parent().get_parent()
	if parent.has_method("addhp"):
		parent.addhp(hpbonus)
	#if parent.has_method("shield"):
	#	parent.shield(10)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





