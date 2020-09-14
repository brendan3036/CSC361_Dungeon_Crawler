extends Node2D


# Declare member variables here. Examples:
const dwarf = preload("res://dwarf_bck.tscn")
const elf = preload("res://elf_bck.tscn")
const cyclops = preload("res://cyclops_bck.tscn")
const zombie = preload("res://zombie_bck.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	# create instances of scenes and use add_child
	var dwarf_instance = dwarf.instance()
	var elf_instance = elf.instance()
	var cyclops_instance = cyclops.instance()
	var zombie_instance = zombie.instance()
	
	# attach the instances to the tree
	self.add_child(elf_instance)
	self.add_child(dwarf_instance)
	self.add_child(cyclops_instance)
	self.add_child(zombie_instance)
	
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
