extends Node

var buildings = []
var economy = {}
var npcs = []
var research = []
var bundles = []
var ads_config = {}

func load_data():
	var paths = {
		"buildings": "res://Data/buildings.json",
		"economy": "res://Data/economy.json",
		"npcs": "res://Data/npc.json",
		"research": "res://Data/research_tree.json",
		"bundles": "res://Data/bundle_config.json",
		"ads": "res://Data/ads_config.json"
	}
	for key in paths.keys():
		var p = paths[key]
		if FileAccess.file_exists(p):
			var f = FileAccess.open(p, FileAccess.READ)
			var txt = f.get_as_text()
			var parsed = JSON.parse_string(txt)
			if parsed.result == OK:
				match key:
					"buildings": buildings = parsed.data
					"economy": economy = parsed.data
					"npcs": npcs = parsed.data
					"research": research = parsed.data
					"bundles": bundles = parsed.data
					"ads": ads_config = parsed.data
				print("Loaded ", key)
			else:
				print("JSON parse error in ", p)
		else:
			print("Missing data file: ", p)
