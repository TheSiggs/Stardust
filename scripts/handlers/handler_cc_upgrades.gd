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

## Returns all cc upgrades
func get_all_upgrades() -> Array[Upgrade]:
	return [
		u_01_stardust_generation,
		u_02_stardust_boost,
		u_03_unlock_nebula
	]

func get_all_unlocked_upgrades() -> Array[Upgrade]:
	var unlocked_upgrades : Array[Upgrade] = []
	for upgrade : Upgrade in get_all_upgrades():
		if upgrade.is_unlocked():
			unlocked_upgrades.append(upgrade)
	return unlocked_upgrades
