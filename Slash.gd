extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var playerPosition = Vector2.ZERO
var slashPosition = Vector2.ZERO
var damage = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	playerPosition = get_tree().get_root().get_child(7).get_child(0).get_global_position()
	connect("area_entered", self, "_on_Slash_area_entered")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Slash_area_entered(area):
	if area.is_in_group("enemy"):
		area.get_parent().health -= damage * get_tree().get_root().get_child(7).get_child(0).damageMult
		#print("hit enemy")
	pass
