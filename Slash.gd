extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var playerPosition = Vector2.ZERO
var slashPosition = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	playerPosition = get_tree().get_root().get_node("Node2D/Node2D/warrior_bck").get_global_position()
	connect("area_entered", self, "_on_Slash_area_entered")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Slash_area_entered(area):
	if area.is_in_group("enemy"):
		# do damage but for now nothing
		print("hit enemy")
	pass
