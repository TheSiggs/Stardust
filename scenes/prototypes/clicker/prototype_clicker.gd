class_name PrototypeClicker
extends Control
## A clicker prototype create stardust

## Reference to label
@export var label : Label

## Stardust
var stardust : int = 0

## Initilize label
func _ready() -> void:
	update_label_text()

## Update stardust label on click
func _on_button_pressed():
	create_stardust()

## Add stardust count
func create_stardust() -> void:
	stardust += 1
	update_label_text()

## Update Label
func update_label_text() -> void:
	label.text = "Stardust : %s" % stardust
