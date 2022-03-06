extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var basedamage = 13
var damage = basedamage
var critmeter = 1
var parent
var kid = null
var velocity = Vector2()
var texit = texture
var rand = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/CollisionShape2D.disabled = true
	#parent = get_owner()
	parent = get_parent().get_parent().get_parent().get_parent()
	kid = get_node("Area2D")
	if kid.has_method("damadzsa"):
		kid.damadzsa(damage)
	if parent.has_method("setaspeed"):
		parent.setaspeed(0.8)
	
	#modulate.r = 1
	#modulate.b = 1
	#parent = get_tree().get_root().get_node("human")
	
	#pass # Replace with function body.

	
	
func attack():
	$Area2D/CollisionShape2D.disabled = false
	if parent.has_method("danger"):
		parent.danger(10)
	rand.randomize()
	damage = basedamage
	if kid.has_method("damadzsa"):
		kid.damadzsa(damage)
	#parent.take_stamige(10)



func steady():
	$Area2D/CollisionShape2D.disabled = true





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	if parent.has_method("danger"):
		parent.danger(damage)
	#pass
