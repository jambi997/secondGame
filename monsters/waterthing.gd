extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var basedamage = 0.5
var damage = basedamage
var critmeter = 1
var parent
var kid = null
var velocity = Vector2()
var rand = RandomNumberGenerator.new()
var speed = 300
var ameter = 0
var targets = []
var target = null
var count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	#parent = get_tree().get_root().get_node("human")
	
	#pass # Replace with function body.

func start_at(pos ):
	position = pos
	#rotation = dir
	

	

func dealdamage():
	frame = 1
	count += 1
	if count > 1:
		queue_free()
	var led = len(targets)
	if led > 0:
		var maxi = targets[0]
		for i in range(0, led):
			#if targets[i].threath > maxi.threath:
			maxi = targets[i]
			maxi.take_damage(-damage)#take_damage(damage)
		target = maxi
		






# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



	#pass


func _on_Timer_timeout():
	dealdamage()
		#damage += 0.001
	#poisoncould()
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	targets.append(body)
	#pass # Replace with function body.


func _on_Area2D_body_exited(body):
	targets.erase(body)
	#pass # Replace with function body.
