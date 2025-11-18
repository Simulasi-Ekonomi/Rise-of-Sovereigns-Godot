# GameManager.gd
# Autoload: name=GameManager, path=res://Scripts/GameManager.gd
extends Node

# Global state
var economy = null
var farm = null
var npc_manager = null
var leaderboard = null
var event_scheduler = null
var ads_manager = null

# bootstrap
func _ready():
    # Initialize subsystems
    economy = preload("res://Scripts/Economy.gd").new()
    farm = preload("res://Scripts/FarmGrid.gd").new()
    npc_manager = preload("res://Scripts/NPCManager.gd").new()
    leaderboard = preload("res://Scripts/Leaderboard.gd").new()
    event_scheduler = preload("res://Scripts/EventScheduler.gd").new()
    ads_manager = preload("res://Scripts/AdsManager.gd").new()

    add_child(economy)
    add_child(farm)
    add_child(npc_manager)
    add_child(leaderboard)
    add_child(event_scheduler)
    add_child(ads_manager)

    economy._init_with_data("res://Data/economy.json")
    farm._init_with_data("res://Data/buildings.json")
    npc_manager._init_with_data("res://Data/npc.json")
    leaderboard._init()
    event_scheduler._init()
    ads_manager._init()

    print("GameManager: systems initialized")

# Hook to save game
func save_game(player_id: String):
    var saver = preload("res://Scripts/SaveLoad.gd").new()
    saver.save_player(player_id)

# Example: award ad reward -> currency
func award_ad_reward(player_id: String, amount: int):
    economy.add_currency(player_id, amount)
    leaderboard.report_change(player_id, economy.get_player_score(player_id))
