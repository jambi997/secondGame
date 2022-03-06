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
var canuse = false
var meter = 0
var spider = preload("res://monsters/spiderfriendly.tscn")
var canspawn = true
var charged = true


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
		parent.setaspeed(0.6)
	#if parent.has_method("adddefense"):
	#	parent.adddefense(-300)
		#parent.speedset(30)
	if parent.has_method("danger"):
		parent.danger(damage)
	
	#parent.global_position.x = parent.global_position.x * -1
	#if parent.has_method("setrange"):
	#	parent.setrange(3)
	#parent = get_tree().get_root().get_node("human")
	
	#pass # Replace with function body.
func _process(delta):
	if charged == true:
		modulate = Color("#4400ff")
		pass
	elif charged == false:
		modulate = Color("#ffffff")
func spawnspider(amount):
	for i in amount:
		var rand = RandomNumberGenerator.new()
		var enemy = spider.instance()# = playerch.instance()
		rand.randomize()
		var x = rand.randf_range(-320, 320)
		var y = rand.randf_range(70, 200)
		#enemy.danger(5000)
		enemy.position.y = y
		enemy.position.x = x
		var parent2 = parent.get_parent()
		parent2.add_child(enemy)
	

		
	
func attack():
	if charged == true:
		damagebonus = 200
		
	elif charged == false:
		damagebonus = 0
		
	$Area2D/CollisionShape2D.disabled = false
	if parent.has_method("danger"):
		parent.danger(10)
	rand.randomize()
	damage = rand.randi_range(5, 10) + damagebonus + basedamage
	charged = false
	#parent.heal(damage/5)
		
	#meter += 1
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





func _on_Area2D2_body_entered(body):
	pass # Replace with function body.


func _on_Area2D2_body_exited(body):
	charged = true
	pass # Replace with function body.
