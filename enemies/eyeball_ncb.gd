extends KinematicBody2D


var rng = RandomNumberGenerator.new()
var x = 1
onready var animatedSprite = $AnimatedSprite
onready var bullet = load("res://enemies/bossProjectile.tscn")
var anim = "idle"
var health = 10
var warrior

func _ready():
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
		if playerPosition.x > bossGlobal.x:
			#bullet x needs to be on the right
			bulletSpawn.x = pos.x + offset
		if playerPosition.y < bossGlobal.y:
			#bullet y needs to be up
			bulletSpawn.y = pos.y - offset
			
		
		var tree = get_tree().get_root()
		tree.add_child(node)
		node.set_position(bulletSpawn)
		
# If the boss dies (1 hit) add 500 score to player and die/end game.
func _process(_delta):
	if health <= 0:
		warrior.addScore(500)
		die()
		
func die():
	var file = File.new()
	file.open("user://temp.dat", file.WRITE)
	file.store_string(str(warrior.score))
	file.close()
	# Free everything in our tree except stuff that is autoloaded.
	for obj in get_tree().get_root().get_children():
		if obj.is_in_group("music") or obj.is_in_group("essential"):
			pass
		else:
			remove_child(obj)
			obj.queue_free()
	get_tree().change_scene("res://menu/GameOverWin.tscn")
