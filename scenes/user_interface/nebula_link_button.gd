extends LinkButton

func _ready() -> void:
	if Game.ref.data.cc_upgrades.u_03_unlock_nebula:
		visible = true
	else:
		visible = false
		HandlerCCUpgrades.ref.u_03_unlock_nebula.leveled_up.connect(_on_ccu03_level_up)

func _on_ccu03_level_up() -> void:
	visible = true
	HandlerCCUpgrades.ref.u_03_unlock_nebula.leveled_up.disconnect(_on_ccu03_level_up)
