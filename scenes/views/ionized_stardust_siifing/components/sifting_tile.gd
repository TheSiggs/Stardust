class_name IonizedStardustSiftingTile
extends TextureButton
## Ionized Stardust Sifting game tile

## Describes tile states
enum Tiles {
	COVERED,
	EMPTY,
	STARDUST,
	CONSCIOUSNESS_CORE
}

## Covered Texture
@export var texture_covered : Texture2D
## Empty Texture
@export var texture_empty : Texture2D
## Stardust Texture
@export var texture_stardust : Texture2D
## Consciousness Core Texture
@export var texture_cc : Texture2D

## Coords in grid
var key : String
var x_coord : int
var y_coord : int

var state : Tiles
var texture : TextureRect

func _ready() -> void:
	state = Tiles.COVERED
	texture = get_node("Texture") 
	texture.texture = texture_covered


func _on_pressed() -> void:
	print("Coords: %s, %s" % [x_coord, y_coord])
	reveal_tile()


func reveal_tile() -> void:
	if state != Tiles.COVERED:
		return
	var roll : int = randi_range(0, 100)
	if roll <= 20:
		state = Tiles.STARDUST
		texture.texture = texture_stardust
	elif roll > 95 && roll <= 100:
		state = Tiles.CONSCIOUSNESS_CORE
		texture.texture = texture_cc
	else:
		state = Tiles.EMPTY
		texture.texture = texture_empty
