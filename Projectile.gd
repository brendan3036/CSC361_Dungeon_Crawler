extends KinematicBody2D


onready var maxSpeed = 300
onready var playerPosition = Vector2.ZERO
onready var direction = Vector2.ZERO
onready var origin = self.global_position

func _ready():
	#playerPosition = get_node("res://warrior_bck.tscn").get_global_position()
	playerPosition = get_tree().get_root().get_node("Node2D/Node2D/warrior_bck").get_global_position()
	#get_tree().get_root().print_tree()
	print(origin)
	direction = (playerPosition - origin).normalized()
	print(direction)

func _physics_process(delta):
	move_and_collide(direction * delta * maxSpeed)
	
func _on_Projectile_body_entered(body):
#	if body.is_in_group("player"):
#		# deal damage and disappear
	queue_free()


