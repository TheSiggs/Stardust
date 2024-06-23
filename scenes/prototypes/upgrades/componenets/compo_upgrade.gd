class_name CompoUpgrade
extends Control
## Component display an upgrade

## Reference title label
@export var label_title: Label
## Reference description
@export var label_description: RichTextLabel
## Reference button
@export var button : Button

## Upgrade to display
var upgrade : Up01ClickerUpgrade


func _ready() -> void:
	upgrade = Up01ClickerUpgrade.new()
	
	update_label_title()
	update_label_description()
	update_button()
	
	HandlerStardust.ref.stardust_created.connect(update_button)
	HandlerStardust.ref.stardust_consumed.connect(update_button)
	
	upgrade.leveled_up.connect(update_label_title)
	upgrade.leveled_up.connect(update_label_description)
	upgrade.leveled_up.connect(update_button)

## Updates title
func update_label_title() -> void:
	label_title.text = upgrade.title + " (%s)" % upgrade.level

## Updates description
func update_label_description() -> void:
	label_description.text = upgrade.get_description()

## Updated the button availibilty
func update_button(_qty : int = -1) -> void:
	button.disabled = not upgrade.can_afford()

## Triggered when purchased button is pressed
func _on_purchase_button_pressed():
	upgrade.level_up()
