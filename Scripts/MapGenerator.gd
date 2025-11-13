extends Node

func generate(parent_node: Node):
	# simple procedural: create 5x3 grid of village labels for preview
	var cols = 5
	var rows = 3
	var spacing = Vector2(160, 120)
	for y in range(rows):
		for x in range(cols):
			var lbl = Label.new()
			lbl.text = "Village %d" % (y*cols + x + 1)
			lbl.position = Vector2(100, 100) + Vector2(x * spacing.x, y * spacing.y)
			parent_node.add_child(lbl)
	print("MapGenerator: generated %d villages" % (cols*rows))
