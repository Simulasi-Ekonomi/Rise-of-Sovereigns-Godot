extends Node2D

@onready var data_loader = preload("res://Scripts/data_loader.gd").new()

func _ready():
	data_loader.load_data()
	print("Game world initialized with buildings and NPCs.")
