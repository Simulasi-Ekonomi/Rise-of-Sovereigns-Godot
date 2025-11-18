# EventScheduler.gd
extends Node

var weekly_ad_bonus = {}
var day = 0

func _init():
    weekly_ad_bonus.clear()
    # This scheduler can be expanded to timers; for now it exposes functions
    print("EventScheduler initialized")

func on_ad_reward(player_id: String):
    if not weekly_ad_bonus.has(player_id):
        weekly_ad_bonus[player_id] = 0
    weekly_ad_bonus[player_id] += 1
    # grant extra free accelerations every 7 ad rewards, etc.
    if weekly_ad_bonus[player_id] % 7 == 0:
        # give free speedups or currency
        GameManager.economy.add_currency(player_id, 50)
        print("EventScheduler: weekly milestone reward for", player_id)
