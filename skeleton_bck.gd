extends KinematicBody2D


# Declare member variables here. Examples:
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement = Vector2(0, 0)
	rng.randomize()
	var x = rng.randi_range(1,4)
	# up
	if x == 1:
		movement = Vector2(0, -1)
	# left
	elif x == 2:
		get_node("AnimatedSprite").flip_h = true
		movement = Vector2(-1, 0)
	# down
	elif x == 3:
		movement = Vector2(0, 1)
	# right
	elif x == 4:
		get_node("AnimatedSprite").flip_h = false
		movement = Vector2(1, 0)
	
	self.move_and_collide(movement)
	

