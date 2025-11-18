# Leaderboard.gd
extends Node

var scores = {} # player_id -> score

func _init():
    scores = {}

func report_change(player_id: String, score: int) -> void:
    scores[player_id] = score
    # placeholder: push to remote server via HTTP later
    print("Leaderboard: player", player_id, "score", score)

func top_n(n: int) -> Array:
    var arr = []
    for k in scores.keys():
        arr.append({"id":k, "score":scores[k]})
    arr.sort_custom(self, "_sort_desc")
    if arr.size() > n:
        arr = arr.slice(0, n)
    return arr

func _sort_desc(a, b):
    return int(b["score"]) - int(a["score"])
