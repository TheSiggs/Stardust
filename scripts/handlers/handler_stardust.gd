class_name HandlerStardust
extends Node
## Manages Stardust resources

## Singleton reference
static var ref : HandlerStardust

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		
		return
	queue_free()

## Created
signal stardust_created(qty : int)
## Consumed
signal stardust_consumed(qty : int)


## Gets stardust amount
func get_stardust() -> int:
	return Game.ref.data.stardust

## Add stardust
func create_stardust(qty : int) -> void:
	Game.ref.data.stardust += qty
	Game.ref.data.universe.stardust += qty
	stardust_created.emit(qty)

## Remove stardust
func consume_stardust(qty : int) -> Error:
	if qty > Game.ref.data.stardust:
		return Error.FAILED
		
	Game.ref.data.stardust -= qty
	stardust_consumed.emit(qty)
	return Error.OK
