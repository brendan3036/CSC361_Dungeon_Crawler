extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Get Parent: ", get_parent())
	print("Get Node: ", get_node("Sprite"))
	print("Get Child: ", get_child(1))
	print("Change Scene: ", get_tree().change_scene("Scene2.tscn"))

	## Array
	# Create Array
	var array = Array()
	for i in range(4):
		array.append(i)
	# Add to Array
	array.append("yay numbers :D")
	# Print number 3 from array and Print Array with for loop
	print(array[3])
	for word in array:
		print(word)
	print(len(array))
	
	## Dictionary
	# Create Dictionary
	var dict = {}
	# Add to Dictionary
	dict["Thing1"] = "Dict"
	dict["Thing2"] = "Dict2"
	dict["Thing3"] = "Dict3"
	# Print Dictionary
	print(dict.Thing2)
	for thing in dict:
		print(thing)
		
		
	for i in range(4,15):
		print(i)
		
	var point = Vector2(45, 90)
	print(point[0],",",point[1])
	print(point.x,",",point.y)
	print(point)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
