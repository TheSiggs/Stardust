class_name ViewConsciousnessCore
extends View
## View Consciousness Core upgrades

@export var ccu_area : Control


## init visibility
func _ready() -> void:
	super()
	visible = false
	initialize_upgrades()

func initialize_upgrades() -> void:
	var upgrades : Array[Upgrade] = HandlerCCUpgrades.ref.get_all_upgrades()
	for upgrade : Upgrade in upgrades:
		var upgradeNode : CompoUpgrade = load("res://scenes/prototypes/upgrades/componenets/compo_upgrade.tscn").instantiate() as CompoUpgrade
		upgradeNode.upgrade = upgrade
		ccu_area.add_child(upgradeNode)
