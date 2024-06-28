class_name HandlerConsciousnessCore
extends Node
## Manages Stardust resources

## Singleton reference
static var ref : HandlerConsciousnessCore

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		
		return
	queue_free()

## emitted on consciousness core creation
signal consciousness_core_created(qty : int)
## emitted on consciousness core consumed
signal consciousness_core_consumed(qty : int)

## Node managing stardust milestones, creating consciouesness cores
@onready var stardust_milestone : MilestoneStardust = MilestoneStardust.new()

## Get current amount of CC
func get_consciousness_core() -> int:
	return Game.ref.data.consciousness_core

## Get create an amount of CC
func create_concsiousness_core(qty : int) -> void:
	Game.ref.data.consciousness_core += qty
	Game.ref.data.universe.consciousness_core += qty
	consciousness_core_created.emit(qty)

## Consume an amount of CC
func consume_concsiousness_core(qty : int) -> Error:
	if qty > Game.ref.data.consciousness_core:
		return Error.FAILED
	Game.ref.data.consciousness_core -= qty
	consciousness_core_consumed.emit(qty)
	return Error.OK
