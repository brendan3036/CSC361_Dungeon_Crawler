extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	self.connect("toggled", self, "_pressed")

func _pressed():
	get_tree().change_scene("HowToPlay.tscn")
