extends KinematicBody2D


# Declare member variables here. Examples:
var rng = RandomNumberGenerator.new()
var x = 1
onready var animatedSprite = $AnimatedSprite
onready var bullet = load("res://bossProjectile.tscn")
#onready var healthBar = get_node("healthBar")
var anim = "idle"
var moveSpeed = 0
var health = 10
var warrior
# Called when the node enters the scene tree for the first time.
func _ready():
#	var parent = get_parent().get_parent().name
#	print("skelly parent's parent = ", parent)
#	var warriorhopefully = get_parent().get_parent().get_child(0).name
#	print("warrior name = ", warriorhopefully)
	warrior = get_tree().get_root().get_node("Game").get_node("warrior_bck")
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = false
	timer.start(1)
	timer.connect("timeout", self, "_timeout")
	
	

func _timeout():
	rng.randomize()
	x = rng.randi_range(1,10)
	if x > 5:
		# We have the player's position
		var playerPosition = warrior.get_global_position()
		# Pos = skeleton's position (locally)
		var pos = get_position()
		var bossGlobal = get_global_position()
		var offset = 20
		var bulletSpawn = Vector2(pos.x - offset, pos.y + offset)
		var node = bullet.instance()
		#node.look_at(playerPosition)
		if playerPosition.x > bossGlobal.x:
			#bullet x needs to be on the right
			bulletSpawn.x = pos.x + offset
		if playerPosition.y < bossGlobal.y:
			#bullet y needs to be up
			bulletSpawn.y = pos.y - offset
			
		
		var tree = get_tree().get_root()
		tree.add_child(node)
		node.set_position(bulletSpawn)
	# up
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#healthBar.value = health
	if health <= 0:
		print("boss ded")
		warrior.addScore(50)
		die()
		
func die():
	var file = File.new()
	file.open("user://temp.dat", file.WRITE)
	file.store_string(str(warrior.score))
	file.close()

	for obj in get_tree().get_root().get_children():
		#slashPos = get_position() + Vector2(1,0)
		if obj.is_in_group("music") or obj.is_in_group("essential"):
			pass
		else:
			remove_child(obj)
			obj.queue_free()
	get_tree().change_scene("GameOverWin.tscn")
