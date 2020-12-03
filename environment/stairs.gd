extends Area2D


var buttonPressFlag = 0
var parentName
func _ready():
	parentName = get_parent().name
	pass
		
# If we are in the area of the stairs and press E, use the stairs to change scenes.
func _process(delta):
	if buttonPressFlag == 1 and Input.is_action_pressed('use'):
		if parentName == "TileMap":
			# Clear the tilemap, keep the player, load the new instance
			get_parent().get_parent().show_map("tileMap_2")
		elif parentName == "TileMap2":
			get_parent().get_parent().show_map("tileMap_3")

# Change button flag based on player entering/exiting area.
func _on_Area2D_entered(area):
	if area.is_in_group("player"):
		buttonPressFlag = 1
		
func _on_Area2D_exited(area):
	if area.is_in_group("player"):
		buttonPressFlag = 0
