extends Node2D


# Brendan
const skeleton = preload("res://skeleton_bck.tscn")
const warrior = preload("res://warrior_bck.tscn")
const blueSlime = preload("res://blueSlime_bck.tscn")
const healthBar = preload("res://GUI.tscn")
var tileMap = load("TileMaps.tscn")
var tileMap_2 = load("TileMaps_2.tscn")

# Nate
var eyeball = load("eyeball_ncb.tscn")
var orc = load("orc_ncb.tscn")
var redSlime = load("redSlime_ncb.tscn")

var firstLevelDone = 0
var current_map
var player
var maps = {
	"tileMap": "res://TileMaps.tscn",
	"tileMap_2": "res://TileMaps_2.tscn"
}
const STARTING_MAP = "tileMap"
# Called when the node enters the scene tree for the first time.
func _ready():
	if not GameMusic.is_playing():
		MenuMusic.stop()
		GameMusic.play()
	load_player(100);
	self.show_map(STARTING_MAP)
	
	
func show_map(map_name):
	if self.current_map != null:
		self.current_map.queue_free()
	self.current_map = load(maps[map_name]).instance()
	self.current_map.z_index = -1
	self.add_child(self.current_map)
	
func load_player(health):
	var node = warrior.instance()
	node.set_position(Vector2(600, 270))
	self.add_child(node)

func _process(delta):
	if Input.is_action_pressed('ui_cancel'):
		get_tree().change_scene("MainMenu.tscn")
		
		
func clear():
	for child in self.get_children():
		if child.is_in_group("tilemap"):
			for chld in child:
				chld.queue_free()
			child.queue_free()
		#child.queue_free()
		print(child)
	self.add_child(tileMap_2.instance())


