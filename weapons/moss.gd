extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var basedamage = 1
var damage = basedamage
var critmeter = 1
var parent
var kid = null
var velocity = Vector2()
var rand = RandomNumberGenerator.new()
var speed = 0
var ameter = 0
var mosshosts = []
# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/CollisionShape2D.disabled = true
	#parent = get_owner()
	parent = get_parent().get_parent().get_parent().get_parent().get_parent()
	kid = get_node("Area2D")
	if kid.has_method("damadzsa"):
		kid.damadzsa(damage)
	
	#parent = get_tree().get_root().get_node("human")
	
	#pass # Replace with function body.

func start_at(pos ):
	position = pos
	#rotation = dir
	

	
func attack():
	$Area2D/CollisionShape2D.disabled = false
	if parent.has_method("danger"):
		parent.danger(10)
	rand.randomize()
	damage =  damage

	if kid.has_method("damadzsa"):
		kid.damadzsa(damage)



func steady():
	$Area2D/CollisionShape2D.disabled = true





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	#if parent.has_method("danger"):
	#	parent.danger(6)
	if area.is_in_group("hurtbox"):
		pass
	#	queue_free()
	#pass


func _on_Timer_timeout():
	if scale.x == 1:
		scale.x = -1
		#if damage < 200:
		damage = damage*2
		if kid.has_method("damadzsa"):
			kid.damadzsa(damage)
		
		var ledd = len(mosshosts)
		for i in ledd:
			var mh =mosshosts[i].get_parent()
			mh.parent.threath += damage*10
			i += 1
		#damage = basedamage
		$Area2D/CollisionShape2D.disabled = true
	elif scale.x == -1:
		scale.x = 1
		damage = damage
		
		$Area2D/CollisionShape2D.disabled = false
		
	
	pass # Replace with function body.


func _on_Area2D2_area_entered(area):
	if area.is_in_group("moss"):
		var ms = area.get_parent()
		if ms.damage < damage: 
			ms.queue_free()
			damage += ms.damage


func _on_Area2D2_area_exited(area):
	pass # Replace with function body.


func _on_Area2D3_area_entered(area):
	if area.is_in_group("mosshost"):
		mosshosts.append(area)


func _on_Area2D3_area_exited(area):
	if area.is_in_group("mosshost"):
		mosshosts.erase(area)
		var led = len(mosshosts)
		if led == 0:
			queue_free()
