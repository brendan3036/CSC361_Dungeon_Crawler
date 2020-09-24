extends Area2D
# Brendan Karper

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered",self,"_on_area_entered")
	
	pass # Replace with function body.

func _on_area_entered(area):
	if area.get_name() == "blop":
		get_node("soundthing").play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
