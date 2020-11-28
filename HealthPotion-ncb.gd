extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var healing = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		var warrior = area.get_parent()
		if warrior.currentHealth == warrior.maxHealth:
			return
		elif warrior.currentHealth <= warrior.maxHealth - healing:
			warrior.currentHealth += healing
			potionDrink.play()
		else:
			warrior.currentHealth = warrior.maxHealth
			potionDrink.play()
		self.get_parent().queue_free()
	else:
		pass
	#print(str('Body entered: ', area.get_name()))
