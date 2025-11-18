# SaveLoad.gd
extends Node

var save_path := "user://saves/"

func save_player(player_id: String) -> void:
    var file = FileAccess.open(save_path + player_id + ".json", FileAccess.WRITE)
    if not file:
        print("SaveLoad: cannot open for write")
        return
    var payload = {
        "economy": GameManager.economy.players.get(player_id, {}),
        "farm": GameManager.farm.plots
    }
    file.store_string(JSON.print(payload))
    file.close()
    print("Saved player:", player_id)

func load_player(player_id: String) -> void:
    var fpath = save_path + player_id + ".json"
    if not FileAccess.file_exists(fpath):
        return
    var file = FileAccess.open(fpath, FileAccess.READ)
    var data = JSON.parse_string(file.get_as_text()).result
    file.close()
    if data.has("economy"):
        GameManager.economy.players[player_id] = data["economy"]
    if data.has("farm"):
        GameManager.farm.plots = data["farm"]
    print("Loaded player:", player_id)
