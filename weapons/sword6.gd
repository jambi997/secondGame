extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var damagebonus = 0
var basedamage = 100
var damage = basedamage
var critmeter = 1
var parent
var kid = null
var velocity = Vector2()
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
		parent.setaspeed(2.5)
		#parent.speedset(30)
	if parent.has_method("danger"):
		parent.danger(damage)
		parent.adddefense(10)
	if parent.has_method("setrange"):
		parent.setrange(2.4)
	#parent = get_tree().get_root().get_node("human")
	
	#pass # Replace with function body.

	
	
func attack():
	$Area2D/CollisionShape2D.disabled = false
	if parent.has_method("danger"):
		parent.danger(10)
	rand.randomize()
	damage = basedamage
	
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
		parent.danger(damage*10)
	#pass
