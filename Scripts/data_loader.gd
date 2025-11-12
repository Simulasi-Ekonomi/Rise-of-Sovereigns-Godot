extends Node

func load_data():
	var files = [
		"res://Data/buildings.json",
		"res://Data/economy.json",
		"res://Data/npc.json",
		"res://Data/research_tree.json",
		"res://Data/bundle_config.json"
	]

	for f in files:
		if FileAccess.file_exists(f):
			var file = FileAccess.open(f, FileAccess.READ)
			var json = JSON.parse_string(file.get_as_text())
			if json.result == OK:
				print("Loaded: ", f, " entries: ", json.data.size())
			else:
				print("Error parsing: ", f)
