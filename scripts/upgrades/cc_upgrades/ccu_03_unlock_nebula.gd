class_name CCU03UnlockNebula
extends Upgrade
## CC Upgrade 03 : Unlock Nebula

var max_level : int = 1

func _init() -> void:
	level = Game.ref.data.cc_upgrades.u_03_unlock_nebula
	title = "Unlock Nebula"
	base_cost = 5
	cost = 5

## Returns description
func get_description() -> String:
	var text : String = "[b]Effects:[/b] Unlocks the ability to create nebula"
	if level < max_level:
		text += "\n[b]Cost:[/b] %s Consciousness Cores" % cost
	return text

##  Calculates whether an upgrade is able to be purchased
func can_afford() -> bool:
	return level < max_level && Game.ref.data.consciousness_core >= cost

## Consumes CC to level up
func level_up() -> void:
	if !can_afford():
		return
	var error : Error = HandlerConsciousnessCore.ref.consume_concsiousness_core(cost)
	if error:
		return
	
	level += 1
	Game.ref.data.cc_upgrades.u_03_unlock_nebula = true
	# Increase leel in Data Reasource
	leveled_up.emit()
	HandlerCCUpgrades.ref.upgrade_leveled_up.emit(self)
	HandlerCCUpgrades.ref.u_03_unlock_nebula.leveled_up.emit(self)
