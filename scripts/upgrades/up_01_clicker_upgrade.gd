class_name Up01ClickerUpgrade
extends Node
## Upgrade 01 - increases stardust created by the clicker

## Signal emitted when this is leveled up
signal leveled_up

## Upgrade level
var level : int = 0
## Upgrade name
var title : String = "Clicker Upgrade"
## Upgrade description
var description : String
## Upgrade initial cost
var base_cost : int = 5
## Current cost of upgrade
var cost : int

## Load upgrade data
func _init() -> void: 
	level = Game.ref.data.up_01_level
	calculate_cost()

## Returns description
func get_description() -> String:
	var _description : String = "Increases the amount of stardust created by the Clicker"
	_description += "\n Effects: +1 Stardust / level"
	_description += "\n Cost: %s" % cost
	return _description

## Returns current cost
func calculate_cost() -> void:
	cost = int(base_cost * pow(1.5, level))


## Calculates whether an upgrade is able to be purchased
func can_afford() -> bool:
	return HandlerStardust.ref.get_stardust() >= cost

## Consumes stardust to level up
func level_up() -> void:
	var error : Error = HandlerStardust.ref.consume_stardust(cost)
	if not error:
		level += 1
		Game.ref.data.up_01_level = level
		calculate_cost()
		leveled_up.emit()
