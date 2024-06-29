class_name ViewUniverse
extends View
## Main view of the game displaying Universe relation info

## Text to display on launch of game
@export var intro_text : Label
## main content to display once the layer has been created
@export var main_content : MarginContainer

func _ready() -> void:
	super()
	_init_view()

## Dispalys the relevant content based on CCU01 status
func _init_view() -> void:
	if not Game.ref.data.cc_upgrades.u_01_stardust_generation_level:
		intro_text.visible = true
		main_content.visible = false
		HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.connect(_on_ccu01_level_up)
	else:
		intro_text.visible = false
		main_content.visible = true

## Wait for CCU01 to be bought
func _on_ccu01_level_up() -> void:
		intro_text.visible = false
		main_content.visible = true
		HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.disconnect(_on_ccu01_level_up)
