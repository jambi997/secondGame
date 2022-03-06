extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tesztfegyer = "kard"

var wep = "res://weapons/sword.tscn"
var ruha = "res://armor/chainvest.tscn"
var wep1 = "res://weapons/sword.tscn"
var ruha1 = "res://armor/chainvest.tscn"
var ruha2 = "res://armor/chainvest.tscn"
var wep2 = "res://weapons/sword.tscn"
var ruha3 = "res://armor/chainvest.tscn"
var wep3 = "res://weapons/sword.tscn"
var ruha4 = "res://armor/chainvest.tscn"
var wep4 = "res://weapons/sword.tscn"
var szekreny = []
var invwep = []
var invarm = []
var loottable = []
var rank = 1
var levelstate = 1
var postomb = []
var it = "res://inventory/weaponinvs/swords/sworditem.tscn"
var axe = "res://inventory/weaponinvs/axes/axe2item.tscn" 
var sword = "res://weapons/sword.tscn"
var kard = "res://inventory/weaponinvs/swords/sworditem.tscn" 
var kard2 = "res://inventory/weaponinvs/swords/sword2item.tscn"  
var kard3 = "res://inventory/weaponinvs/swords/sword3item.tscn"
var bow = "res://inventory/weaponinvs/bows/bowitem.tscn"
var chanwest = "res://inventory/armorinvs/armoritem.tscn"
var goldarmor = "res://inventory/armorinvs/goldarmoritem.tscn"
var chanwest2 = "res://inventory/armorinvs/armoritem2.tscn"
var staff = "res://inventory/weaponinvs/staffs/staff1item.tscn"
var numb = 0
var invlimit = 110
var parent
var nextroom = "res://maps/map1.tscn" #"res://menu.tscn"
var zsakmany = [ "res://inventory/armorinvs/vorostextilpancel2.tscn" , "res://inventory/armorinvs/vorostextilpancel.tscn"   ,  "res://inventory/weaponinvs/axes/axeitem.tscn",  "res://inventory/weaponinvs/bows/bowitem.tscn", "res://inventory/weaponinvs/swords/sword2item.tscn" ,  "res://inventory/weaponinvs/swords/sword3item.tscn"     ]
var bosszsakmany = [ "res://inventory/weaponinvs/swords/sword11item.tscn" ,"res://inventory/weaponinvs/axes/axe3item.tscn" ,"res://inventory/weaponinvs/bows/bowitem3.tscn" , "res://inventory/armorinvs/armoritem4.tscn"        ,"res://inventory/weaponinvs/swords/sword6item.tscn"  ,"res://inventory/weaponinvs/bows/crossbowitem.tscn"  , "res://inventory/armorinvs/vorostextilpancel3.tscn" , "res://inventory/armorinvs/armoritem3.tscn" ,"res://inventory/weaponinvs/swords/sword5item.tscn" , "res://inventory/weaponinvs/swords/sword4item.tscn", "res://inventory/armorinvs/armoritem2.tscn", "res://inventory/weaponinvs/axes/axe2item.tscn" ,  "res://inventory/weaponinvs/swords/katanaitem.tscn"        ]
var rarezsakmany = ["res://inventory/armorinvs/armoritem10.tscn" ,"res://inventory/weaponinvs/swords/sword13item.tscn" ,"res://inventory/weaponinvs/swords/sword12item.tscn" , "res://inventory/weaponinvs/swords/sword10item.tscn" , "res://inventory/weaponinvs/bows/crossbowitem2.tscn" , "res://inventory/armorinvs/armoritem9.tscn"  , "res://inventory/armorinvs/armoritem8.tscn"  ,  "res://inventory/weaponinvs/swords/sword8item.tscn" , "res://inventory/weaponinvs/swords/sword7item.tscn"    , "res://inventory/armorinvs/armoritem7.tscn" ,"res://inventory/armorinvs/armoritem6.tscn" ,"res://inventory/armorinvs/armoritem5.tscn" , "res://inventory/weaponinvs/swords/firesworditem.tscn"   , "res://inventory/weaponinvs/bows/bowitem2.tscn"  ,"res://inventory/weaponinvs/swords/healsworditem.tscn" ]
const allies = preload("res://characters/human3.tscn")
var rand = RandomNumberGenerator.new()
var nextdung = "res://misc/dungeonchooser.tscn"
var enemiest1 = ["res://monsters/pangulin.tscn","res://monsters/spider.tscn" ]
var enemiest2 = ["res://monsters/boar3.tscn","res://monsters/bigspider.tscn" ]
var enemiest3 = ["res://monsters/bigestspider.tscn","res://monsters/watermage.tscn" ]
var enemiest4 = ["res://monsters/watermage2.tscn","res://monsters/bigestspiderspawner.tscn"]
var enemiest5 = ["res://monsters/boar4.tscn", "res://monsters/turtle.tscn"]
##################################
var v1 = true
var v2 = true
var v3 = true
var v4 = true
var v5 = true


#######################################

func addloot3():
	rarezsakmany.shuffle()
	szekreny.append(rarezsakmany[0])

func addloot2():
	bosszsakmany.shuffle()
	szekreny.append(bosszsakmany[0])
func addloot():
	zsakmany.shuffle()
	szekreny.append(zsakmany[0])



func postoltes():
	var led = len(postomb)
	for i in 5:
		var enemy = allies.instance()
		rand.randomize()
		var x = rand.randf_range(-200, -320)
		rand.randomize()
		var y = rand.randf_range(70, 200)
		enemy.position.y = y
		enemy.position.x = x								
		enemy.id = i
		postomb.append(enemy.position)
		i += 1
		pass

func _ready():
	rand.randomize()
	var ismet = rand.randi_range(1,100)
	for i in range(1, ismet):
		zsakmany.shuffle()
		bosszsakmany.shuffle()
	addloot()
	addloot()
	addloot()
	addloot()
	addloot()
	addloot()
	addloot()
	addloot()
	addloot()
	addloot2()
	#for i in 30:
	#	addloot3()
	#szekreny.append(axe)
	#szekreny.append(kard)
	#szekreny.append(kard2)
	#szekreny.append(kard3)
	#szekreny.append(bow)
	#szekreny.append(chanwest2)
	#szekreny.append(goldarmor)
	#szekreny.append(staff)
	invwep.append(it)
	invwep.append(it)
	invwep.append(it)
	invwep.append(it)
	invwep.append(it)
	invwep.append(it)
	invwep.append(it)
	invwep.append(it)
	invarm.append(chanwest)
	invarm.append(chanwest)
	invarm.append(chanwest)
	invarm.append(chanwest)
	invarm.append(chanwest)
	invarm.append(chanwest)
	#szekreny.erase(axe)
	#szekreny.append(sword)
	postoltes()
	
	
	









# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
