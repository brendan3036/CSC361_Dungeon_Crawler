extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"on_collision_now")
	pass # Replace with function body.
	
func on_collision_now(who):
	#print("hi")
	#print(self.get_name()," is colliding with ",who.get_name())
	if who.get_name() == "Wall1" or who.get_name() == "Wall2" or who.get_name() == "Wall3" or who.get_name() == "Wall4":
		get_node("squeak").play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("click"):
		# apply impulse
		self.apply_impulse(Vector2(0,0), Vector2(2,-2))
	
#	pass
