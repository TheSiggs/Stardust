class_name ViewSiftingMinigame
extends View
## Ionized Stardust Sifting Minigame view

## Reference to the PackedScene containing a tile
@export var packed_tile: PackedScene

## Reference Timer
@export var automation_timer : Timer

## List of tiles
@export var tiles : Dictionary

@export var sifting_level_label : Label

## Whether or not the game sifts the tiles automatically
var is_automated : bool = false

## Init the view
func _ready() -> void:
	super()
	generate_tiles()
	update_level_label()

## Generate tiles for the minigame
func generate_tiles() -> void:
	for x : int in 5:
		for y : int in 5:
			var key : String = "%s,%s" % [x, y]
			
			var node : IonizedStardustSiftingTile = packed_tile.instantiate() as IonizedStardustSiftingTile
			
			node.x_coord = x
			node.y_coord = y
			node.key = key
			
			node.tile_revealed.connect(_on_tile_revealed)
			
			$IonizedMiniGameGridContainer.add_child(node)
			tiles[key] = node

func reset_tiles() -> void:
	for key : String in tiles:
		@warning_ignore("unsafe_method_access")
		tiles.get(key).init()


func _on_button_pressed() -> void:
	reset_tiles()


func _on_automation_timer_timeout() -> void:
	if !is_automated || !self.visible:
		return
	for key : String in tiles:
		@warning_ignore("untyped_declaration")
		var tile = tiles.get(key) as IonizedStardustSiftingTile
		if tile.state == IonizedStardustSiftingTile.Tiles.COVERED:
			tile.reveal_tile(3)
			return
	if tiles[tiles.keys()[tiles.keys().size() - 1]].state != IonizedStardustSiftingTile.Tiles.COVERED:
		reset_tiles()


func _on_automation_button_toggled(toggled_on : bool) -> void:
	is_automated = toggled_on

func _on_tile_revealed() -> void:
	progress_sifting_level()

func progress_sifting_level() -> void:
	Game.ref.data.sifting.progress += 1
	check_for_level_up()

func check_for_level_up() -> void:
	var reach : int = int(pow(8, Game.ref.data.sifting.level + 1))
	if Game.ref.data.sifting.progress >= reach:
		Game.ref.data.sifting.level += 1
		Game.ref.data.sifting.progress = 0
		update_level_label()
		HandlerStardustGenerator.ref.calculate_generated_power()


func update_level_label() -> void:
	sifting_level_label.text = "Sifting Level: %s" % Game.ref.data.sifting.level
