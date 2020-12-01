extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var playerPosition = Vector2.ZERO
var slashPosition = Vector2.ZERO
var damage = 50
var warrior
# Called when the node enters the scene tree for the first time.
func _ready():
	warrior = get_tree().get_root().get_node("Game").get_node("warrior_bck")
	playerPosition = warrior.get_global_position()
	connect("area_entered", self, "_on_Slash_area_entered")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Slash_area_entered(area):
	if area.is_in_group("enemy"):
		area.get_parent().health -= damage * warrior.damageMult
		#print("hit enemy")
	pass
