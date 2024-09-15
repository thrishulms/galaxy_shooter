extends Node2D

# Scroll speed for each layer (can be the same for all, or different for parallax)
var scroll_speeds = [100]

# List of TileMap layers
var tilemap_layers: Array = []

func _ready():
	# Add each TileMap layer to the array (this assumes they are children of the parent node)
	for child in get_children():
		if child is TileMapLayer:
			tilemap_layers.append(child)

func _process(delta):
	# Scroll each TileMap layer individually
	for i in range(tilemap_layers.size()):
		var tilemap = tilemap_layers[i]
		var speed = scroll_speeds[0]
		var map_height = 13 * tilemap.get_used_rect().size.y
		
		# Move the TileMap downwards
		tilemap.position.y += speed * delta
		
		# When the TileMap moves out of bounds, reposition it
		if tilemap.position.y >= map_height:
			tilemap.position.y = 0
