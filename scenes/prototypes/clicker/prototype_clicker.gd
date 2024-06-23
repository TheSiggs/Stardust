class_name PrototypeClicker
extends View
## A clicker prototype create stardust

## Initilize label
func _ready() -> void:
	super()
	visible = false

## Update stardust label on click
func _on_button_pressed():
	create_stardust()

## Add stardust count
func create_stardust() -> void:
	HandlerStardust.ref.trigger_clicker()

