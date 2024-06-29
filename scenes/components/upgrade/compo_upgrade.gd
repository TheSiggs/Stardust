class_name CompoUpgrade
extends Control
## Component display an upgrade

## Reference title label
@export var label_title: Label
## Reference description
@export var label_description: RichTextLabel
## Reference button
@export var button : Button
## Reference veil
@export var veil : ColorRect

## Upgrade to display
var upgrade : Upgrade


func _ready() -> void:
	update_component()
	
	if not upgrade.is_disabled():
		HandlerStardust.ref.stardust_created.connect(_on_upgrade_level_up)
		HandlerStardust.ref.stardust_consumed.connect(_on_upgrade_level_up)
		upgrade.leveled_up.connect(_on_upgrade_level_up)

func update_component() -> void:
	update_label_title()
	update_label_description()
	update_button()
	update_veil()

## Updates title
func update_label_title() -> void:
	label_title.text = upgrade.title()

## Updates description
func update_label_description() -> void:
	label_description.text = upgrade.get_description()

## Updated the button availibilty
func update_button(_qty : int = -1) -> void:
	button.disabled = not upgrade.can_afford()

## Hides or show veil based on upgrade disabled
func update_veil() -> void:
	veil.visible = upgrade.is_disabled()

## Triggered when purchased button is pressed
func _on_purchase_button_pressed() -> void:
	upgrade.level_up()

## Update component and disconnect signals on disabled
func _on_upgrade_level_up() -> void:
	update_component()
	if upgrade.is_disabled():
		HandlerStardust.ref.stardust_created.disconnect(update_button)
		HandlerStardust.ref.stardust_consumed.disconnect(update_button)
		upgrade.leveled_up.disconnect(update_component)
