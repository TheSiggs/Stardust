class_name Nebula
extends Node
## Abstract class which describes a nebula

signal composition_updated

## Name of the nebula
var given_name : String = "Unnamed Nebula"
## Amount of stardust inside nebula
var stardust : int = 0
## How much the nebula will consume per second
var stardust_consumes : int = 1
## Index of the nebula data
var data_index : int = -1

## Tries to consume stardust
func _on_consume_stardust() -> void:
	var error : Error = HandlerStardust.ref.consume_stardust(stardust_consumes)
	if error:
		return
	
	stardust += stardust_consumes
	Game.ref.data.nebula[data_index].stardust = stardust
	
	composition_updated.emit()
