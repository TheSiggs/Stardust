class_name Data
extends Resource
## Contains data to save and load

## Current stardust
@export var stardust : int = 0

## Current amount of consciousness cores available
@export var consciousness_core : int = 10

## Current amount of ionized stardust
@export var ionized_stardust : int = 0

## Contains CCUpgrade data
@export var cc_upgrades : DataCCUpgrades = DataCCUpgrades.new()

## Universe data to save/load
@export var universe : DataUniverse = DataUniverse.new()

## Contains Nebula data
@export var nebula : Array[DataNebula] = []

## Placeholder Names
@export var placeholder_names : Array[String] = ["Orion Nebula", "Eagle Nebula", "Crab Nebula", "Horsehead Nebula", "Helix Nebula", "Ring Nebula", "Carina Nebula", "Butterfly Nebula", "Cat's Eye Nebula", "Rosette Nebula",
	"Trifid Nebula", "Lagoon Nebula", "Dumbbell Nebula", "Omega Nebula", "Veil Nebula", "Heart Nebula", "Soul Nebula", "North America Nebula", "Crescent Nebula", "Cone Nebula",
	"Bubble Nebula", "Tarantula Nebula", "Eskimo Nebula", "Ghost Nebula", "Red Rectangle Nebula", "Spaghetti Nebula", "Hourglass Nebula", "Blue Snowball Nebula", "Jellyfish Nebula",
	"Pelican Nebula", "California Nebula", "Flame Nebula", "Elephant's Trunk Nebula", "Retina Nebula", "Medusa Nebula", "Pacman Nebula", "Seagull Nebula", "Snowball Nebula",
	"Seahorse Nebula", "Boogeyman Nebula", "Monkey Head Nebula", "Little Dumbbell Nebula", "Swan Nebula", "Witch Head Nebula", "Southern Crab Nebula", "Minkowski's Butterfly", "Little Ghost Nebula"]
