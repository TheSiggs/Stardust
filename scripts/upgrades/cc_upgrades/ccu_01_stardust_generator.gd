class_name CCU01StardustGenerator
extends Upgrade
## Unlockes the passive Stardust generation


func _init() -> void:
	level = Game.ref.data.cc_upgrades.u_01_stardust_generation_level
	base_cost = 1
	max_level = 1
	calculate_cost()

## Returns description
func get_description() -> String:
	var text : String = "Awaken the Universe to start generating Stardust"
	text += "\n[b]Effect: [/b] Passive Stardust generation"
	if !is_max_level():
		text += "\n[b]Cost:[/b] %s Consciousness Cores" % cost

	return text

## Returns current cost
func calculate_cost() -> void:
	cost = base_cost


## Calculates whether an upgrade is able to be purchased
func can_afford() -> bool:
	return !is_max_level() && Game.ref.data.consciousness_core >= cost

## Consumes CC to level up
func level_up() -> void:
	if !can_afford():
		return
	var error : Error = HandlerConsciousnessCore.ref.consume_concsiousness_core(cost)
	if error:
		return
	
	level += 1
	Game.ref.data.cc_upgrades.u_01_stardust_generation_level = true
	# Increase leel in Data Reasource
	leveled_up.emit()
	HandlerCCUpgrades.ref.upgrade_leveled_up.emit(self)
	HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.emit(self)

## Returns whether upgrade is unlocked
func is_unlocked() -> bool:
	return true

## Returns upgrade title
func title() -> String:
	return "Awaken the Universe"

## Returns whether upgrade is disabled
func is_disabled() -> bool:
	return Game.ref.data.cc_upgrades.u_01_stardust_generation_level
