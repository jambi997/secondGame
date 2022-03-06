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
var speed = 300
var ameter = 0
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

func start_at(pos ,dir):
	position = pos
	rotation = dir
	
func _physics_process(delta):
	position -= transform.x * speed * delta
	ameter += 1
	if ameter >= 1:
		$Area2D/CollisionShape2D.disabled = false
	
func attack():
	$Area2D/CollisionShape2D.disabled = false
	if parent.has_method("danger"):
		parent.danger(10)
	rand.randomize()
	damage =  basedamage

	if kid.has_method("damadzsa"):
		kid.damadzsa(damage)



func steady():
	$Area2D/CollisionShape2D.disabled = true





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	if parent.has_method("danger"):
		parent.danger(6)
	if area.is_in_group("hurtbox"):
		queue_free()
	#pass
