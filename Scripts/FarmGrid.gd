# FarmGrid.gd
extends Node

# configuration
var grid_width = 6
var grid_height = 6
var plots = [] # array of dictionaries {crop_id, planted_time, growth_stage}

func _init_with_data(path: String) -> void:
    # optionally read building config to determine grid size
    var f = FileAccess.open(path, FileAccess.READ)
    if f:
        var cfg = JSON.parse_string(f.get_as_text()).result
        if cfg.has("grid"):
            grid_width = int(cfg["grid"].get("width", grid_width))
            grid_height = int(cfg["grid"].get("height", grid_height))
        f.close()
    _create_grid()
    print("FarmGrid initialized:", grid_width, "x", grid_height)

func _create_grid():
    plots.clear()
    for y in range(grid_height):
        for x in range(grid_width):
            plots.append({"crop_id": null, "planted_time": 0, "growth_stage": 0})

func plant_crop(player_id: String, plot_index: int, crop_id: String, timestamp: int) -> bool:
    if plot_index < 0 or plot_index >= plots.size():
        return false
    var p = plots[plot_index]
    if p["crop_id"] != null:
        return false
    p["crop_id"] = crop_id
    p["planted_time"] = timestamp
    p["growth_stage"] = 0
    return true

func harvest_plot(player_id: String, plot_index: int) -> Dictionary:
    var p = plots[plot_index]
    if p["crop_id"] == null:
        return {"ok":false}
    var crop_id = p["crop_id"]
    var yield_amount = 1 # simplified
    p["crop_id"] = null
    p["planted_time"] = 0
    p["growth_stage"] = 0
    # report production to economy
    GameManager.economy.add_production(player_id, yield_amount)
    return {"ok":true, "crop":crop_id, "yield":yield_amount}
