class_name HandlerLiquidStardust
extends Node
## Manages Liquid Stardust resources

## Singleton reference
static var ref : HandlerLiquidStardust

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		
		return
	queue_free()

## Created
signal liquid_stardust_created(qty : int)
## Consumed
signal liquid_stardust_consumed(qty : int)


## Gets Liquid stardust amount
func get_liquid_stardust() -> int:
	return Game.ref.data.liquid_stardust

## Add Liquid stardust
func create_liquid_stardust(qty : int) -> void:
	Game.ref.data.liquid_stardust += qty
	Game.ref.data.universe.liquid_stardust += qty
	liquid_stardust_created.emit(qty)

## Remove Liquid stardust
func consume_liquid_stardust(qty : int) -> Error:
	if qty > Game.ref.data.liquid_stardust:
		return Error.FAILED
		
	Game.ref.data.liquid_stardust -= qty
	liquid_stardust_consumed.emit(qty)
	return Error.OK
