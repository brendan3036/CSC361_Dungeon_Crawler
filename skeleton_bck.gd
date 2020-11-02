extends KinematicBody2D


# Declare member variables here. Examples:
var rng = RandomNumberGenerator.new()
var x = 1
onready var animatedSprite = $AnimatedSprite
onready var bullet = load("res://Projectile.tscn")
var anim = "idle"
# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.start(.5)
	timer.connect("timeout", self, "_timeout")
	
	

func _timeout():
	rng.randomize()
	x = rng.randi_range(1,10)
	# up
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement = Vector2(0, 0)
	if x == 1:
		anim = "walking"
		movement = Vector2(0, -.5)
	# left
	elif x == 2:
		anim = "walking"
		get_node("AnimatedSprite").flip_h = true
		movement = Vector2(-.5, 0)
	# down
	elif x == 3:
		anim = "walking"
		movement = Vector2(0, .5)
	# right
	elif x == 4:
		anim = "walking"
		get_node("AnimatedSprite").flip_h = false
		movement = Vector2(.5, 0)
	# up
	else:
		anim = "idle"
		movement = Vector2(0,0)
#		var pos = get_position()
#		var node = bullet.instance()
#		var tree = get_tree().get_root()
#		tree.add_child(node)
#		node.set_position(Vector2(pos.x - 1, pos.y - 1))
	
	animatedSprite.play(anim)
	self.move_and_collide(movement)
	

