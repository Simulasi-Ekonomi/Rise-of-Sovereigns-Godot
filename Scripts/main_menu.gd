extends Control

func _ready():
	print("MainMenu ready")

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/GameWorld.tscn")
