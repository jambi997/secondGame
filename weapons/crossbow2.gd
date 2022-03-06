extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var basedamage = 10
var damage = basedamage
var critmeter = 1
var parent
var kid = null
var velocity = Vector2()
var rand = RandomNumberGenerator.new()
var canshoot = true
var fball = preload("res://weapons/arrow.tscn")
var startammo = 100
var ammo = startammo
var timi = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/CollisionShape2D.disabled = true
	#parent = get_owner()
	parent = get_parent().get_parent().get_parent().get_parent()
	kid = get_node("Area2D")
	if kid.has_method("damadzsa"):
		kid.damadzsa(damage)
	if parent.has_method("setaspeed"):
		parent.setaspeed(1.3)
	#parent = get_tree().get_root().get_node("human")
	
	#pass # Replace with function body.

	
func shoot():
	canshoot= false
	var b = fball.instance()
	b.start_at($mouth.global_position, $mouth.global_rotation)
	$bullet.add_child(b)
	$shoottimer.start()
	$shoottimer.wait_time = parent.aspeed
	
func shoot2():
	canshoot= false
	var b = fball.instance()
	b.start_at($mouth2.global_position, $mouth.global_rotation)
	$bullet.add_child(b)
	$shoottimer.start()
	$shoottimer.wait_time = parent.aspeed
	
func attack():
	if canshoot == true:
		$Timer.start()
	#$Area2D/CollisionShape2D.disabled = false
	if parent.has_method("danger"):
		parent.danger(20)
	rand.randomize()
	damage = basedamage

	if kid.has_method("damadzsa"):
		kid.damadzsa(damage)




func steady():
	$Area2D/CollisionShape2D.disabled = true





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	if parent.has_method("danger"):
		parent.danger(10)
	#pass


func _on_shoottimer_timeout():
	canshoot = true
	ammo = startammo

func _on_Timer_timeout():
	#canshoot = true
	if ammo > 0 :
		if timi == 0:
			shoot()
			timi = 1
		elif timi == 1:
			shoot2()
			timi = 0
		$Timer.start()
		ammo -= 1
	
	
	
	
