class_name HandlerStardustGenerator
extends Node
## Passively generates Stardust

## Singleton reference
static var ref : HandlerStardustGenerator

## Amount of Stardust generated every loop
var generator_power : int = 1

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
	calculate_generated_power()
	HandlerCCUpgrades.ref.upgrade_leveled_up.connect(watch_for_upgrades_level_up)
	
	if Game.ref.data.cc_upgrades.u_01_stardust_generation_level:
		timer.start()
		return
	HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.connect(watch_for_ccu01_level_up)

## Triggered when an upgrade levels up. Recalculates generator power
func watch_for_upgrades_level_up(upgrade : Upgrade) -> void:
	calculate_generated_power()

## Triggered when timer completes loop
func _on_timer_timeout():
	HandlerStardust.ref.create_stardust(generator_power)

## wait for ccu_01 being purchased
func watch_for_ccu01_level_up(upgrade : Upgrade) -> void:
	timer.start()
	HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.disconnect(watch_for_ccu01_level_up)

## Calcualtes the amount of stardust which should be created every second
func calculate_generated_power() -> void:
	var new_power : int = 1
	new_power += Game.ref.data.cc_upgrades.u_02_stardust_boost_level
	generator_power = new_power
