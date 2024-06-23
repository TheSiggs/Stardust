class_name PrototypeClicker
extends Control
## A clicker prototype create stardust


## View Reference
@export var view : UserInterface.Views 
## Reference UI
@export var user_interface : UserInterface


## Initilize label
func _ready() -> void:
	visible = true
	user_interface.navigation_requested.connect(_on_navigation_request)

## Update stardust label on click
func _on_button_pressed():
	create_stardust()

## Add stardust count
func create_stardust() -> void:
	HandlerStardust.ref.create_stardust(1)


## Watch for nav requests
func _on_navigation_request(requested_view : UserInterface.Views) -> void:
	if requested_view == view:
		visible = true
		return
	
	visible = false
