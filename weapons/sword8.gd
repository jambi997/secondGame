extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var damagebonus = 0
var basedamage = 30
var damage = basedamage
var critmeter = 1
var parent
var kid = null
var velocity = Vector2()
var rand = RandomNumberGenerator.new()
var dad = null
var canuse = false
var meter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#modulate.r8 = 0
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


func knightmode():
	damagebonus = 100
	#parent.setaspeed(-1)
	parent.modulate.g8 = 0
	parent.modulate.b8 = 0
	meter = 0
	$Timer.start()
	
	
func attack():
	$Area2D/CollisionShape2D.disabled = false
	if parent.has_method("danger"):
		parent.danger(10)
	rand.randomize()
	damage = rand.randi_range(5, 10) + damagebonus + basedamage
	meter += 1
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
	if meter > 20:
		knightmode()
		# Replace with function body.


func _on_Timer_timeout():
	canuse = true
	parent.modulate.g8 = 255
	parent.modulate.b8 = 255
	damagebonus = 0
	meter = 0

func _on_Timer2_timeout():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var numbiti = rand.randi_range(1,5)
	meter += numbiti
