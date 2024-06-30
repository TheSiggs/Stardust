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

## Modifier applied to stardust generation
var effect_stardust_generation : int = 0

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
	var ionized_stardust_to_create : int = -1
	var stardust_to_consume : int = -1
	
	if stardust >= 100:
		ionized_stardust_to_create = 5
		stardust_to_consume = 9
	elif stardust >= 25:
		ionized_stardust_to_create = 2
		stardust_to_consume = 3
	
	var error : Error = consume_stardust(stardust_to_consume)
	if error || ionized_stardust_to_create == -1 || stardust_to_consume == -1:
		return
	
	ionized_stardust += ionized_stardust_to_create
	Game.ref.data.universe.ionized_stardust += ionized_stardust_to_create
	Game.ref.data.nebula[data_index].ionized_stardust = ionized_stardust
	calculate_effect_stardust_generation()
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
		calculate_effect_stardust_generation()
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


func calculate_effect_stardust_generation() -> void:
	var old_effect : int = effect_stardust_generation
	
	if ionized_stardust >= 25:
		effect_stardust_generation = 1
	
	if ionized_stardust >= 100:
		effect_stardust_generation = 2
	
	if effect_stardust_generation != old_effect:
		HandlerNebula.ref.calculate_nebula_effect_stardust_generation()

## Triggered when the Nebula timer times-out
func _on_nebula_timer_timeout() -> void:
	attract_stardust()
	refine_stardust()
	release_ionized_stardust()
