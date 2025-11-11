extends Control

func _ready():
	print("Main menu loaded.")

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/GameWorld.tscn")

func _on_quit_pressed():
	get_tree().quit()
