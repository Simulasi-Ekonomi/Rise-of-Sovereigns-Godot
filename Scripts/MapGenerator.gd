extends Node

func generate(parent_node: Node):
	# simple procedural grid using Labels for preview
	var cols = 8
	var rows = 5
	var spacing = Vector2(160, 120)
	var base = Vector2(80, 80)
	for y in range(rows):
		for x in range(cols):
			var lbl = Label.new()
			lbl.text = "Village %d" % (y*cols + x + 1)
			lbl.position = base + Vector2(x * spacing.x, y * spacing.y)
			parent_node.add_child(lbl)
	print("MapGenerator: generated %d villages" % (cols*rows))
