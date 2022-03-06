extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const itemclass = preload("res://misc/draggeditem.tscn")
var item = null
# Called when the node enters the scene tree for the first time.
func _ready():
	item = itemclass.instance()
	add_child(item)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
