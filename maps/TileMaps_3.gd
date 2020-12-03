extends Node2D

# Load ALL possible scenes we could instance.
var healthPotion = load("res://environment/HealthPotion-ncb.tscn")
var skelly = load("res://enemies/skeleton_bck.tscn")
var redSlime = load("res://enemies/redSlime_ncb.tscn")
var blueSlime = load("res://enemies/blueSlime_bck.tscn")
var warrior = load("res://player/warrior_bck.tscn")
var coins = load("res://environment/Coins.tscn")
var doubleScorePotion = load("res://environment/doubleScorePotion.tscn")
var doubleDamagePotion = load("res://environment/doubleDamagePotion.tscn")
var torch = load("res://environment/torch.tscn")
var redBanner = load("res://environment/redBanner.tscn")
var blueBanner = load("res://environment/blueBanner.tscn")
var blackBanner = load("res://environment/blackBanner.tscn")
var fire = load("res://environment/fire_bck.tscn")
var stairs = load("res://environment/stairs.tscn")
var eyeball = load("res://enemies/eyeball_ncb.tscn")
var gem = load("res://environment/gem.tscn")
var princess = load("res://environment/Princess.tscn")

var tileMap
var xy
func _ready():
	# Play the boss room music.
	if not BossMusic.is_playing():
		MenuMusic.stop()
		GameMusic.stop()
		BossMusic.play()
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
		elif name == "redBanner":
			node = redBanner.instance()
		elif name == "blueBanner":
			node = blueBanner.instance()
		elif name == "blackBanner":
			node = blackBanner.instance()
		elif name == "fire":
			node = fire.instance()
		elif name == "stairs":
			node = stairs.instance()
		elif name == "eyeball":
			node = eyeball.instance()
		elif name == "princess":
			node = princess.instance()
		place_node(node, pos)
	pass

func place_node(node, pos):
	self.add_child(node)
	node.set_position(Vector2(pos.x * xy[0] + (0.5*xy[0]), pos.y * xy[1] + (0.5*xy[1])))
	tileMap.set_cell(pos.x, pos.y, -1) # Should make tile invisible
