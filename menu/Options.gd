extends Button

func _ready():
	self.connect("toggled", self, "_pressed")

func _pressed():
	get_tree().change_scene("res://menu/Options.tscn")

