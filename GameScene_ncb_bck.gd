extends Node2D


# Brendan
const skeleton = preload("res://skeleton_bck.tscn")
const warrior = preload("res://warrior_bck.tscn")
const blueSlime = preload("res://blueSlime_bck.tscn")
var tileMap = load("TileMaps.tscn")

# Nate
var eyeball = load("eyeball_ncb.tscn")
var orc = load("orc_ncb.tscn")
var redSlime = load("redSlime_ncb.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	# Brendan
	var skeleton_instance = skeleton.instance()
	var warrior_instance = warrior.instance()
	var blueSlime_instance = blueSlime.instance()
	self.add_child(tileMap.instance())
	
	# attach the instances to the tree - Brendan
	#self.add_child(skeleton_instance)
	#self.add_child(warrior_instance)
	self.add_child(blueSlime_instance)
	
	# Nate
	self.add_child(eyeball.instance())
	#self.add_child(orc.instance())
	#self.add_child(redSlime.instance())
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
