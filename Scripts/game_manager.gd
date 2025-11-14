extends Node2D

var data_loader = null
var map_gen = null

func _ready():
	# load data loader scene (so it's present)
	var dl = preload("res://Scenes/Systems/DataLoader.tscn").instantiate()
	add_child(dl)
	data_loader = dl
	data_loader.load_data()
	# create HUD (already instanced in scene)
	# generate map
	map_gen = preload("res://Scripts/map_generator.gd").new()
	map_gen.generate(self)
	print("GameManager: ready")
