class_name ViewSiftingMinigame
extends View
## Ionized Stardust Sifting Minigame view

## Reference to the PackedScene containing a tile
@export var packed_tile: PackedScene

## Reference Timer
@export var automation_timer : Timer

## List of tiles
@export var tiles : Dictionary

## Whether or not the game sifts the tiles automatically
var is_automated : bool = false

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


func _on_automation_timer_timeout():
	if !is_automated || !self.visible:
		return
	for key : String in tiles:
		var tile = tiles.get(key) as IonizedStardustSiftingTile
		if tile.state == IonizedStardustSiftingTile.Tiles.COVERED:
			tile.reveal_tile(3)
			return
	if tiles[tiles.keys()[tiles.keys().size() - 1]].state != IonizedStardustSiftingTile.Tiles.COVERED:
		reset_tiles()


func _on_automation_button_toggled(toggled_on):
	is_automated = toggled_on
