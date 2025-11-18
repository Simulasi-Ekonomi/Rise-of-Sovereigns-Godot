# AdsManager.gd
extends Node

# This file implements the reward logic; integrate real SDK calls per platform
var reward_per_ad = 10

func _init():
    print("AdsManager init")

# Called when ad watched successfully
func on_rewarded_ad_complete(player_id: String):
    GameManager.award_ad_reward(player_id, reward_per_ad)
    # Every time an ad reward given, increase a weekly counter (handled by EventScheduler)
    GameManager.event_scheduler.on_ad_reward(player_id)
