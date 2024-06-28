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

## reference to u_01_stardust_generation
@onready var u_01_stardust_generation : CCU01StardustGenerator = CCU01StardustGenerator.new()

## reference to u_02_stardust_boost
@onready var u_02_stardust_boost : CCu02StardustBoost = CCu02StardustBoost.new()

## Returns all cc upgrades
func get_all_upgrades() -> Array[Upgrade]:
	return [
		u_01_stardust_generation,
		u_02_stardust_boost
	]
