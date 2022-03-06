extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var damagebonus = 0
var basedamage = 40
var damage = basedamage
var critmeter = 1
var parent
var kid = null
var velocity = Vector2()
var rand = RandomNumberGenerator.new()
var dad = null
var canfreeze = true
# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.r8 = 0
	$Area2D/CollisionShape2D.disabled = true
	#parent = get_owner()
	parent = get_parent().get_parent().get_parent().get_parent()
	kid = get_node("Area2D")
	if kid.has_method("damadzsa"):
		kid.damadzsa(damage)
	if parent.has_method("setaspeed"):
		parent.setaspeed(1)
		#parent.speedset(30)
	#if parent.has_method("danger"):
		#parent.danger(damage*100)
	#parent.global_position.x = parent.global_position.x * -1
	#if parent.has_method("setrange"):
	#	parent.setrange(3)
	#parent = get_tree().get_root().get_node("human")
	
	#pass # Replace with function body.

	
	
func attack():
	$Area2D/CollisionShape2D.disabled = false
	if parent.has_method("danger"):
		parent.danger(10)
	rand.randomize()
	damage = rand.randi_range(5, 10) + damagebonus + basedamage
	if canfreeze == true and dad != null and dad.speed > 10:
		dad.speed -= 10
		canfreeze = false
		modulate.r8 = 255
		$Timer.start()
		if dad.speed < 10:
			dad.speed = 10
	#parent.take_stamige(5)


	if kid.has_method("damadzsa"):
		kid.damadzsa(damage)



func steady():
	$Area2D/CollisionShape2D.disabled = true





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	if parent.has_method("danger"):
		parent.danger(damage)
	if area.is_in_group("hurtbox"):
		dad = area.get_parent().get_parent().get_parent().get_parent()


func _on_Area2D_area_exited(area):
	if dad == area:
		dad = null
		
		# Replace with function body.


func _on_Timer_timeout():
	canfreeze = true
	modulate.r8 = 0
