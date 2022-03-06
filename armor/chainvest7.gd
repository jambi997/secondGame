extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var armor = 10
var hpbonus = 0
var parent
var healtarget = null
var targets = []
var heal = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent().get_parent().get_parent()
	if parent.has_method("addhp"):
		parent.addhp(hpbonus)
	#if parent.has_method("shield"):
	#	parent.shield(100)
	if parent.has_method("danger"):
		parent.danger(200)
	if parent.has_method("addattackspeed"):
		pass
		parent.addattackspeed(2)
		#parent.modulate.a8 = 70
		parent.speedset(-40)
	#if parent.has_method("addattackspeed"):
	#	parent.addattackspeed(-0.2)
	#pass # Replace with function body.

func _process(delta):
	var led = len(targets)
	if led >0:
		var maxi = targets[0]
		for i in range(1, led):
			if targets[i].hp/targets[i].starthp < maxi.hp/maxi.starthp:
				maxi = targets[i]
			healtarget= maxi
		
	if healtarget != null:
		healtarget.heal(heal)
		parent.danger(heal)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area2D_body_entered(body):
	if body.has_method("heal"):
		targets.append(body)
		if healtarget == null:
			healtarget = body

func _on_Area2D_body_exited(body):
	if body.has_method("heal"):
		targets.erase(body)
		if healtarget == body:
			healtarget == null
	
	
