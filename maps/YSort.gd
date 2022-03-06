extends YSort


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pauseing(false)

func _process(delta):
	pass


func pauseing(pauseed):
	if pauseed == true:
		set_process(false)
	elif pauseed == false:
		set_process(true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
