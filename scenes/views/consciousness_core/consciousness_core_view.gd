class_name ViewConsciousnessCore
extends View
## View Consciousness Core upgrades

@export var ccu_area : Control

## If enabled will show all upgrades including upgrades at max level
var show_max_level_upgrades : bool = true

## init visibility
func _ready() -> void:
	super()
	visible = false
	initialize_upgrades()
	connect_signals()

## Connects signals
func connect_signals() -> void:
	HandlerCCUpgrades.ref.upgrade_unlocked.connect(_on_upgrade_unlocked)
	HandlerCCUpgrades.ref.upgrade_leveled_up.connect(show_hide_upgrade_on_upgrade_level_up)

##
func initialize_upgrades() -> void:
	var upgrades : Array[Upgrade]
	
	if show_max_level_upgrades:
		upgrades = HandlerCCUpgrades.ref.get_all_unlocked_upgrades()
	else:
		upgrades = HandlerCCUpgrades.ref.get_all_available_upgrades()
	
	for upgrade : Upgrade in upgrades:
		create_upgrade_node(upgrade)

##
func _on_upgrade_unlocked(_upgrade : Upgrade) -> void:
	var current_upgrades : Array[Upgrade] = []
	
	for current_upgrade_node : Node in ccu_area.get_children():
		var upgrade : Upgrade = current_upgrade_node.upgrade as Upgrade
		if show_max_level_upgrades || !upgrade.is_max_level():
			current_upgrades.append(upgrade)
		else:
			current_upgrade_node.queue_free()
		
	for upgrade : Upgrade in HandlerCCUpgrades.ref.get_all_unlocked_upgrades():
		if !current_upgrades.has(upgrade):
			if upgrade.is_max_level() && !show_max_level_upgrades:
				continue
			create_upgrade_node(upgrade)

## Shows or Hides newly upgraded Upgrade
func show_hide_upgrade_on_upgrade_level_up(upgrade : Upgrade) -> void:
	if show_max_level_upgrades || !upgrade.is_max_level():
		return
	for current_upgrade_node : Node in ccu_area.get_children():
		var current_upgrade : Upgrade = current_upgrade_node.upgrade as Upgrade
		if current_upgrade == upgrade:
			current_upgrade_node.queue_free()

## Reloads all upgrades
func rerender_upgrades() -> void:
	for child_node : Node in ccu_area.get_children():
		child_node.queue_free()
	initialize_upgrades()

##
func create_upgrade_node(upgrade : Upgrade) -> void:
	var upgradeNode : CompoUpgrade = load("res://scenes/components/upgrade/compo_upgrade.tscn").instantiate() as CompoUpgrade
	upgradeNode.upgrade = upgrade
	ccu_area.add_child(upgradeNode)

##
func _on_show_hide_max_upgrade_button_toggled(toggled_on: bool) -> void:
	show_max_level_upgrades = not toggled_on
	rerender_upgrades()
