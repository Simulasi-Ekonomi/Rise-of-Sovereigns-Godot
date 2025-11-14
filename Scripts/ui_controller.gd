extends Node

func update_resources(gold:int, diamonds:int):
	var hud = get_tree().get_root().get_node("GameWorld/CanvasLayerHUD/HUDInstance")
	if hud:
		var lbl_gold = hud.get_node("TopBar/LabelGold")
		var lbl_dia = hud.get_node("TopBar/LabelDiamonds")
		if lbl_gold: lbl_gold.text = "Gold: %d" % gold
		if lbl_dia: lbl_dia.text = "Diamonds: %d" % diamonds
