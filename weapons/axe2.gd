extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var basedamage = 20
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
		parent.setaspeed(1.5)
	parent.danger(100)
	#parent = get_tree().get_root().get_node("human")
	
	#pass # Replace with function body.

	
	
func attack():
	$Area2D/CollisionShape2D.disabled = false
	#if parent.has_method("danger"):
	#	parent.danger(10)
	rand.randomize()
	var thdamage = 0
	if parent.threath > 0:
		thdamage = parent.threath / 100
	damage = rand.randi_range(10, 20) +  basedamage + thdamage
	#if damage < 15 and parent.has_method("danger"):    (parent.threath / 100)
		#parent.heal(damage)
	#	parent.danger(damage)
	#if parent.has_method("take_stamige"):
	#	parent.take_stamige(15)
	if kid.has_method("damadzsa"):
		kid.damadzsa(damage)



func steady():
	$Area2D/CollisionShape2D.disabled = true





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	if parent.has_method("danger"):
		parent.danger(damage*2)
	#pass
