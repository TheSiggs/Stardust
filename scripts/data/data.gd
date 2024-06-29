class_name Data
extends Resource
## Contains data to save and load

## Current stardust
@export var stardust : int = 0

## Current amount of consciousness cores available
@export var consciousness_core : int = 100

## Contains CCUpgrade data
@export var cc_upgrades : DataCCUpgrades = DataCCUpgrades.new()

## Universe data to save/load
@export var universe : DataUniverse = DataUniverse.new()

## Contains Nebula data
@export var nebula : Array[DataNebula] = []
