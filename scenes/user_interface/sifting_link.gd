extends LinkButton

func _ready() -> void:
	if Game.ref.data.cc_upgrades.u_06_unlock_sifting:
		visible = true
	else:
		visible = false
		HandlerCCUpgrades.ref.u_06_unlock_sifting.leveled_up.connect(_on_ccu06_level_up)

func _on_ccu06_level_up() -> void:
	visible = true
	HandlerCCUpgrades.ref.u_06_unlock_sifting.leveled_up.disconnect(_on_ccu06_level_up)
