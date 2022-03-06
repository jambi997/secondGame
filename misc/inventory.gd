extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const dragged = preload("res://misc/draggeditem.tscn")
#onready var startingslot = get_node("GridContainer/Slot1")
var startingslot #= $GridContainer/Slot1.position
# Called when the node enters the scene tree for the first time.
func _ready():
	#startingslot = $GridContainer/Slot1.position
	additem()
	#pass # Replace with function body.

func additem():
	var item = dragged.instance()
	item.start_at($Position2D.position, rotation)
	add_child(item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
