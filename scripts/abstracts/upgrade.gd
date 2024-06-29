class_name Upgrade
extends Node
## Abstract class defining an upgrade

## Signal emitted when this is leveled up
signal leveled_up

## Emitted when upgrade is unlocked
signal upgrade_unlocked

## Upgrade level
var level : int = -1

## Upgrade description
var description : String
## Upgrade initial cost
var base_cost : int = -1
## Current cost of upgrade
var cost : int = -1


## Virtual function - returns upgrade title
func title() -> String:
	return "Title not found"

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

func int_to_roman(number: int) -> String:
	var roman_numerals : Dictionary = {
		1000: "M", 900: "CM", 500: "D", 400: "CD",
		100: "C", 90: "XC", 50: "L", 40: "XL",
		10: "X", 9: "IX", 5: "V", 4: "IV", 1: "I"
	}
	
	var sorted_keys : Array = roman_numerals.keys()
	sorted_keys.sort()
	sorted_keys.reverse()
	var roman_numeral : String = ""
	
	for value : int in sorted_keys:
		while number >= value:
			roman_numeral += roman_numerals[value]
			number -= value
	
	return roman_numeral

## Virtual function - Returns whether upgrade is disabled
func is_disabled() -> bool:
	printerr("level_up not defined")
	assert(false)
	return false
