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
	init()


func _on_pressed() -> void:
	reveal_tile()


func reveal_tile(cost : int = 1) -> void:
	if state != Tiles.COVERED:
		return
	var error : Error = HandlerIonizedStardust.ref.consume_ionized_stardust(cost)
	if error:
		return
	var roll : int = randi_range(0, 100)
	if roll <= 20:
		state = Tiles.STARDUST
		texture.texture = texture_stardust
		var stardust_found : int = randi_range(1, 5)
		HandlerStardust.ref.create_stardust(stardust_found)
	elif roll > 98 && roll <= 100:
		state = Tiles.CONSCIOUSNESS_CORE
		texture.texture = texture_cc
		HandlerConsciousnessCore.ref.create_concsiousness_core(1)
	else:
		state = Tiles.EMPTY
		texture.texture = texture_empty

func init() -> void:
	state = Tiles.COVERED
	texture = get_node("Texture") 
	texture.texture = texture_covered
