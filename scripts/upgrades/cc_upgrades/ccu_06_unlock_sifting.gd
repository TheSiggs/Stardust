class_name CCU06UnlockSifting
extends Upgrade
## CC Upgrade 06 : Unlock Sifting


func _init() -> void:
	level = Game.ref.data.cc_upgrades.u_06_unlock_sifting
	base_cost = 5
	cost = 5
	max_level = 1
	connect_signals()

func connect_signals() -> void:
	if not is_unlocked():
		HandlerCCUpgrades.ref.u_03_unlock_nebula.leveled_up.connect(_on_ccu03_level_up)

## Returns description
func get_description() -> String:
	var text : String = "[b]Effects:[/b] Unlocks the ability to sift through the stars"
	if !is_max_level():
		text += "\n[b]Cost:[/b] %s Consciousness Cores" % cost
	return text

##  Calculates whether an upgrade is able to be purchased
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
	Game.ref.data.cc_upgrades.u_06_unlock_sifting = true
	# Increase level in Data Reasource
	leveled_up.emit()
	HandlerCCUpgrades.ref.upgrade_leveled_up.emit(self)
	HandlerCCUpgrades.ref.u_06_unlock_sifting.leveled_up.emit(self)

## Returns whether upgrade is unlocked
func is_unlocked() -> bool:
	return Game.ref.data.cc_upgrades.u_03_unlock_nebula

## Triggered when CCU01 is purchased. Unlocks this upgrade
func _on_ccu03_level_up() -> void:
	HandlerCCUpgrades.ref.u_03_unlock_nebula.leveled_up.disconnect(_on_ccu03_level_up)
	HandlerCCUpgrades.ref.upgrade_unlocked.emit(self)

## Returns upgrade title
func title() -> String:
	return "Unlock Sifting"

## Returns whether upgrade is disabled
func is_disabled() -> bool:
	return Game.ref.data.cc_upgrades.u_06_unlock_sifting
