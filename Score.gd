extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("user://temp.dat", file.READ)
	var content = file.get_as_text()
	file.close()
	var dir = Directory.new()
	dir.remove("user://temp.dat")
	self.text = "Score: " + str(content)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
