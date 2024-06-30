class_name HandlerIonizedStardust
extends Node
## Manage Ionized Stardust

## Singleton reference
static var ref : HandlerIonizedStardust

## Singleton check
func _singleton_check() -> void:
	if not ref:
		ref = self
		return
	queue_free()

## Game initialization
func _enter_tree() -> void:
	_singleton_check()

# ------------------------------------------

signal ionized_stardust_created(qty : int)
signal ionized_stardust_consumed(qty : int)

## Gets ionized stardust amount
func get_ionized_stardust() -> int:
	return Game.ref.data.ionized_stardust

## Add ionized stardust
func create_ionized_stardust(qty : int) -> void:
	Game.ref.data.ionized_stardust += qty
	
	ionized_stardust_created.emit(qty)

## Remove ionized stardust
func consume_ionized_stardust(qty : int) -> Error:
	if qty > Game.ref.data.ionized_stardust:
		return Error.FAILED
		
	Game.ref.data.ionized_stardust -= qty
	ionized_stardust_consumed.emit(qty)
	return Error.OK
