class_name HandlerStardustGenerator
extends Node
## Passively generates Stardust

## Singleton reference
static var ref : HandlerStardustGenerator

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	queue_free()

## Reference to generator timer
@export var timer : Timer

## Load data
func _ready() -> void:
	if Game.ref.data.cc_upgrades.u_01_stardust_generation_level:
		timer.start()
		return
		
	HandlerCCUpgrades.ref.upgrade_leveled_up.connect(watch_for_upgrades_level_up)

## Triggered when timer completes loop
func _on_timer_timeout():
	HandlerStardust.ref.create_stardust(1)

## wait for ccu_01 being purchased
func watch_for_upgrades_level_up(upgrade : Upgrade) -> void:
	if upgrade == HandlerCCUpgrades.ref.u_01_stardust_generation:
		timer.start()
		HandlerCCUpgrades.ref.upgrade_leveled_up.disconnect(watch_for_upgrades_level_up)
