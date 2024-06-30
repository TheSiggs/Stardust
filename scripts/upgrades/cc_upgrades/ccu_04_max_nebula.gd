class_name CCU04MaxNebula
extends Upgrade
## Increases the max amount of Nebula the players can create

var max_level : int = 3

func _init() -> void:
	level = Game.ref.data.cc_upgrades.u_04_max_nebula_level
	base_cost = 2
	cost = 2
	
	if not is_unlocked():
		HandlerCCUpgrades.ref.u_03_unlock_nebula.leveled_up.connect(_on_ccu03_level_up)

## returns upgrade title
func title() -> String:
	return "Nebula Capacity Upgrade %s" % int_to_roman(level)

## returns description
func get_description() -> String:
	var text : String = "Increases the amount of Nebulas you can create"
	text += "\n[b]Effects:[/b] Nebula capacity +1"
	if !is_max_level():
		text += "\n[b]Cost:[/b] %s Consciousness Cores" %  cost
	return text

## Returns current cost
func calculate_cost() -> void:
	match level:
		0:
			cost = base_cost
		1:
			cost = 5
		2:
			cost = 10
		3:
			cost = -1

## Calculates whether an upgrade is able to be purchased
func can_afford() -> bool:
	return !is_max_level() && Game.ref.data.consciousness_core >= cost

## Consumes stardust to level up
func level_up() -> void:
	if !can_afford():
		return
	var error : Error = HandlerConsciousnessCore.ref.consume_concsiousness_core(cost)
	if error:
		return
	
	level += 1
	Game.ref.data.cc_upgrades.u_04_max_nebula_level = level
	calculate_cost()
	# Increase leel in Data Reasource
	leveled_up.emit()
	HandlerCCUpgrades.ref.upgrade_leveled_up.emit(self)
	HandlerCCUpgrades.ref.u_04_max_nebula_level.leveled_up.emit(self)

## returns whether upgrade is unlocked
func is_unlocked() -> bool:
	return Game.ref.data.cc_upgrades.u_03_unlock_nebula

## Returns whether upgrade is disabled
func is_disabled() -> bool:
	return is_max_level()


func _on_ccu03_level_up() -> void:
	HandlerCCUpgrades.ref.u_03_unlock_nebula.leveled_up.disconnect(_on_ccu03_level_up)
	HandlerCCUpgrades.ref.upgrade_unlocked.emit(self)

func is_max_level() -> bool:
	return level >= max_level
