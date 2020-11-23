extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var healthPotion = load("HealthPotion-ncb.tscn")
var skelly = load("skeleton_bck.tscn")
var orc = load("orc_ncb.tscn")
var redSlime = load("redSlime_ncb.tscn")
var warrior = load("warrior_bck.tscn")
var coins = load("Coins.tscn")
var doubleScorePotion = load("doubleScorePotion.tscn")
var doubleDamagePotion = load("doubleDamagePotion.tscn")
var torch = load("torch.tscn")

# Called when the node enters the scene tree for the first time.
var tileMap
var xy
func _ready():
	# Add potions to TileMap
	tileMap = get_node("Placeholder")
	xy = tileMap.get_cell_size()
	
	var tiles = tileMap.get_tileset()
	var usedTiles = tileMap.get_used_cells()
	for pos in usedTiles :
		var tileID = tileMap.get_cell(pos.x, pos.y)
		var name = tiles.tile_get_name(tileID)
		var node
		if name == "warrior" :
			node = warrior.instance()
		elif name == "skeleton" :
			node = skelly.instance()
		elif name == "orc" :
			node = orc.instance()
		elif name == "red slime":
			node = redSlime.instance()
		elif name == "potion":
			node = healthPotion.instance()
		elif name == "coins":
			node = coins.instance()
		elif name == "doubleScorePotion":
			node = doubleScorePotion.instance()
		elif name == "doubleDamagePotion":
			node = doubleDamagePotion.instance()
		elif name == "torch":
			node = torch.instance()
		place_node(node, pos)
	pass

func place_node(node, pos):
	self.add_child(node)
	node.set_position(Vector2(pos.x * xy[0] + (0.5*xy[0]), pos.y * xy[1] + (0.5*xy[1])))
	tileMap.set_cell(pos.x, pos.y, -1) # Should make tile invisible

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
