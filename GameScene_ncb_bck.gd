extends Node2D

var warrior = load("res://player/warrior_bck.tscn")
var current_map
var maps = {
	"tileMap": "res://maps/TileMaps.tscn",
	"tileMap_2": "res://maps/TileMaps_2.tscn",
	"tileMap_3": "res://maps/TileMaps_3.tscn"
}
const STARTING_MAP = "tileMap"

func _ready():
	if not GameMusic.is_playing():
		MenuMusic.stop()
		BossMusic.stop()
		GameMusic.play()
	load_player();
	self.show_map(STARTING_MAP)
	
# If we have a current map, free it up.
# Load an instance of whatever map we pass in and add it as a child of Game.
func show_map(map_name):
	if self.current_map != null:
		self.current_map.queue_free()
	self.current_map = load(maps[map_name]).instance()
	self.current_map.z_index = -1
	self.add_child(self.current_map)

# Load an instance of player into our designated starting position as a child of Game.
func load_player():
	var node = warrior.instance()
	node.set_position(Vector2(600, 270))
	self.add_child(node)

# No pause screen for now. If press 'esc' go to Menu.
func _process(delta):
	if Input.is_action_pressed('ui_cancel'):
		get_tree().change_scene("MainMenu.tscn")
		
		


