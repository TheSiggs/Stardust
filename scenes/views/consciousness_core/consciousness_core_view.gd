class_name ViewConsciousnessCore
extends View
## View Consciousness Core upgrades

@export var ccu_area : Control


## init visibility
func _ready() -> void:
	super()
	visible = false
	initialize_upgrades()
	HandlerCCUpgrades.ref.upgrade_unlocked.connect(_on_upgrade_unlocked)

func initialize_upgrades() -> void:
	var upgrades : Array[Upgrade] = HandlerCCUpgrades.ref.get_all_unlocked_upgrades()
	for upgrade : Upgrade in upgrades:
		create_upgrade_node(upgrade)

func _on_upgrade_unlocked(_upgrade : Upgrade) -> void:
	var current_upgrades : Array[Upgrade] = []
	
	for current_upgrade_node : Node in ccu_area.get_children():
		var upgrade = current_upgrade_node.upgrade
		current_upgrades.append(upgrade)
	
	for upgrade : Upgrade in HandlerCCUpgrades.ref.get_all_unlocked_upgrades():
		if !current_upgrades.has(upgrade):
			create_upgrade_node(upgrade)

func create_upgrade_node(upgrade : Upgrade) -> void:
	var upgradeNode : CompoUpgrade = load("res://scenes/components/upgrade/compo_upgrade.tscn").instantiate() as CompoUpgrade
	upgradeNode.upgrade = upgrade
	ccu_area.add_child(upgradeNode)
