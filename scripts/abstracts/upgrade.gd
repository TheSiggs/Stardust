class_name Upgrade
extends Node
## Abstract class defining an upgrade

## Signal emitted when this is leveled up
signal leveled_up

## Emitted when upgrade is unlocked
signal upgrade_unlocked

## Upgrade level
var level : int = -1
## Upgrade name
var title : String = "Not Defined"
## Upgrade description
var description : String
## Upgrade initial cost
var base_cost : int = -1
## Current cost of upgrade
var cost : int = -1


## Virtual function - returns description
func get_description() -> String:
	assert(false)
	return "Undefined Description"

## Virtual function - Returns current cost
func calculate_cost() -> void:
	printerr("Calculate cost not defined")
	assert(false)

## Virtual function - Calculates whether an upgrade is able to be purchased
func can_afford() -> bool:
	assert(false)
	return false

## Virtual function - Consumes stardust to level up
func level_up() -> void:
	printerr("level_up not defined")
	assert(false)

## Virtual function - returns whether upgrade is unlocked
func is_unlocked() -> bool:
	printerr("is_unlocked not defined")
	assert(false)
	return false
