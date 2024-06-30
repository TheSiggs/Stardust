class_name ViewSiftingMinigame
extends Control
## Ionized Stardust Sifting Minigame view

## Reference to the PackedScene containing a tile
@export var packed_tile: PackedScene

## List of tiles
@export var tiles : Dictionary

## Init the view
func _ready() -> void:
	generate_tiles()

## Generate tiles for the minigame
func generate_tiles() -> void:
	for x : int in 5:
		for y : int in 5:
			var key : String = "%s,%s" % [x, y]
			
			var node : IonizedStardustSiftingTile = packed_tile.instantiate() as IonizedStardustSiftingTile
			
			node.x_coord = x
			node.y_coord = y
			node.key = key
			
			$IonizedMiniGameGridContainer.add_child(node)
			tiles[key] = node
