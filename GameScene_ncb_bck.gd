extends Node2D


# Brendan
const dwarf = preload("res://dwarf_bck.tscn")
const elf = preload("res://elf_bck.tscn")
const cyclops = preload("res://cyclops_bck.tscn")
const zombie = preload("res://zombie_bck.tscn")

# Nate
var randomGuy = load("RandomGuy.tscn")
var potato = load("Potato.tscn")
var egg = load("Egg.tscn")
var seal = load("Seal.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Brendan
	var dwarf_instance = dwarf.instance()
	var elf_instance = elf.instance()
	var cyclops_instance = cyclops.instance()
	var zombie_instance = zombie.instance()
	
	# attach the instances to the tree - Brendan
	self.add_child(elf_instance)
	self.add_child(dwarf_instance)
	self.add_child(cyclops_instance)
	self.add_child(zombie_instance)
	
	# Nate
	self.add_child(randomGuy.instance())
	self.add_child(potato.instance())
	self.add_child(egg.instance())
	self.add_child(seal.instance())
	
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
