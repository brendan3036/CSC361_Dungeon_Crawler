extends Control

onready var audioPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	if audioPlayer.playing == false:
			audioPlayer.play()
	pass

