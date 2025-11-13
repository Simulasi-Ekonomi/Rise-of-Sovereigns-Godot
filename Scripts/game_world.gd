extends Node2D

@onready var DataLoader = preload("res://Scripts/data_loader.gd").new()

func _ready():
	print("GameWorld ready")
	DataLoader.load_data()
	# generate map using MapGenerator
	var gen = preload("res://Scripts/MapGenerator.gd").new()
	gen.generate(self)
