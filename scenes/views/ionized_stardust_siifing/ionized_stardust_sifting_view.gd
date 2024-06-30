class_name ViewSiftingMinigame
extends View
## Ionized Stardust Sifting Minigame view

## Reference to the PackedScene containing a tile
@export var packed_tile: PackedScene

## List of tiles
@export var tiles : Dictionary

## Init the view
func _ready() -> void:
	super()
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

func reset_tiles() -> void:
	for key : String in tiles:
		@warning_ignore("unsafe_method_access")
		tiles.get(key).init()


func _on_button_pressed() -> void:
	reset_tiles()
