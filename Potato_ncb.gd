extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"on_collision_now")
	pass # Replace with function body.

func on_collision_now(who):
	if who.get_name() == "Wall1" or who.get_name() == "Wall2" or who.get_name() == "Wall3" or who.get_name() == "Wall4":
		get_node("boom").play()
		

func _process(delta):
	if Input.is_action_pressed("Rclick"):
		# apply impulse
		self.apply_impulse(Vector2(0,0), Vector2(-2,-2))
