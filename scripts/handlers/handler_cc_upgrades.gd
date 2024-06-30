class_name HandlerCCUpgrades
extends Node
## Manages Stardust resources

## Singleton reference
static var ref : HandlerCCUpgrades

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	queue_free()


## Emitted when upgrade has leveled
signal upgrade_leveled_up(upgrade : Upgrade)

## Emitted when an upgrade is unlocked
signal upgrade_unlocked(upgrde : Upgrade)

## reference to u_01_stardust_generation
@onready var u_01_stardust_generation : CCU01StardustGenerator = CCU01StardustGenerator.new()
## reference to u_02_stardust_boost
@onready var u_02_stardust_boost : CCu02StardustBoost = CCu02StardustBoost.new()
## reference to u_03_unlock_nebula
@onready var u_03_unlock_nebula : CCU03UnlockNebula = CCU03UnlockNebula.new()
## Reference to u_04_max_nebula
@onready var u_04_max_nebula_level : CCU04MaxNebula = CCU04MaxNebula.new()
## Reference to u_05_attraction_power
@onready var u_05_attraction_power : CCU05AttractionPower = CCU05AttractionPower.new()
## Refrence to u_06_unlock_sifting
@onready var u_06_unlock_sifting : CCU06UnlockSifting = CCU06UnlockSifting.new()

## Returns all cc upgrades
func get_all_upgrades() -> Array[Upgrade]:
	return [
		u_01_stardust_generation,
		u_02_stardust_boost,
		u_03_unlock_nebula,
		u_04_max_nebula_level,
		u_05_attraction_power,
		u_06_unlock_sifting
	]


## Gets all unlocked upgrades
func get_all_unlocked_upgrades() -> Array[Upgrade]:
	var unlocked_upgrades : Array[Upgrade] = []
	for upgrade : Upgrade in get_all_upgrades():
		if upgrade.is_unlocked():
			unlocked_upgrades.append(upgrade)
	return unlocked_upgrades

## Gets all upgrades which are avaiable and able to be bought
func get_all_available_upgrades() -> Array[Upgrade]:
	var available_upgrade : Array[Upgrade] = []
	
	for upgrade : Upgrade in get_all_unlocked_upgrades():
		if !upgrade.is_max_level():
			available_upgrade.append(upgrade)
	return available_upgrade
