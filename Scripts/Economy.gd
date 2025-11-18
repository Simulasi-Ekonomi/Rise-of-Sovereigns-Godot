# Economy.gd
extends Node

# simple in-memory economy, persists via SaveLoad
var players = {} # dictionary player_id -> {currency:int, production_score:int}

func _init_with_data(path: String) -> void:
    # Load base economy config (prices, base incomes)
    var f = FileAccess.open(path, FileAccess.READ)
    if f:
        var cfg = JSON.parse_string(f.get_as_text()).result
        # keep cfg for item prices, etc.
        self.set("config", cfg)
        f.close()
    print("Economy loaded config:", path)

func ensure_player(player_id: String) -> void:
    if not players.has(player_id):
        players[player_id] = {"currency": 0, "production_score": 0}

func add_currency(player_id: String, amount: int) -> void:
    ensure_player(player_id)
    players[player_id]["currency"] += amount

func spend_currency(player_id: String, amount: int) -> bool:
    ensure_player(player_id)
    if players[player_id]["currency"] >= amount:
        players[player_id]["currency"] -= amount
        return true
    return false

func get_currency(player_id: String) -> int:
    ensure_player(player_id)
    return players[player_id]["currency"]

func add_production(player_id: String, amount: int) -> void:
    ensure_player(player_id)
    players[player_id]["production_score"] += amount

func get_player_score(player_id: String) -> int:
    ensure_player(player_id)
    return players[player_id]["production_score"]
