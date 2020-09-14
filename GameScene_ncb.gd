extends Node2D


# Declare member variables here. Examples:
var randomGuy = load("RandomGuy.tscn")
var potato = load("Potato.tscn")
var egg = load("Egg.tscn")
var seal = load("Seal.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_child(randomGuy.instance())
	self.add_child(potato.instance())
	self.add_child(egg.instance())
	self.add_child(seal.instance())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
