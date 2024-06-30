class_name Nebula
extends Node
## Abstract class which describes a nebula

signal composition_updated

## Name of the nebula
var given_name : String = "Unnamed Nebula"
## Amount of stardust inside nebula
var stardust : int = 0

## Index of the nebula data
var data_index : int = -1

## Ionized stardust
var ionized_stardust : int = 0

## How much stardust the nebula will attract per second
var attraction_value : int = 1

## Amount of ionized stardust being released
var release_value : int = 1

## Tries to consume stardust
func attract_stardust() -> void:
	var error : Error = HandlerStardust.ref.consume_stardust(attraction_value)
	if error:
		return
	
	stardust += attraction_value
	Game.ref.data.nebula[data_index].stardust = stardust
	
	composition_updated.emit()


## Transforms stardust into Ionized Stardust
func refine_stardust() -> void:
	if stardust >= 25:
		var error : Error = consume_stardust(3)
		if error:
			return
		
		const ionized_stardust_to_create : int = 2
		
		ionized_stardust += ionized_stardust_to_create
		Game.ref.data.universe.ionized_stardust += ionized_stardust_to_create
		Game.ref.data.nebula[data_index].ionized_stardust = ionized_stardust
		
		composition_updated.emit()


## Tries to consume stardust
func consume_stardust(qty: int) -> Error:
	if stardust >= qty:
		stardust -= qty
		Game.ref.data.nebula[data_index].stardust = stardust
		return Error.OK
	return Error.FAILED

## Tries to consume ionized stardust
func consume_ionized_stardust(qty: int) -> Error:
	if ionized_stardust >= qty:
		ionized_stardust -= qty
		Game.ref.data.nebula[data_index].ionized_stardust = ionized_stardust
		return Error.OK
	return Error.FAILED


## Consume ionized stardust from the nebula to release
func release_ionized_stardust() -> void:
	var qty : int = -1
	
	if release_value > ionized_stardust:
		qty = ionized_stardust
	else:
		qty = release_value
	
	var error : Error = consume_ionized_stardust(qty)
	if error:
		return
	
	HandlerIonizedStardust.ref.create_ionized_stardust(qty)

## Triggered when the Nebula timer times-out
func _on_nebula_timer_timeout() -> void:
	attract_stardust()
	refine_stardust()
	release_ionized_stardust()
