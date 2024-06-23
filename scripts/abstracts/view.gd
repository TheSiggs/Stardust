class_name View
extends Control
## Abstract class defining a view

## View Reference
@export var view : UserInterface.Views 
## Reference UI
@export var user_interface : UserInterface


## Initilize visibility
func _ready() -> void:
	user_interface.navigation_requested.connect(_on_navigation_request)

## Watch for nav requests
func _on_navigation_request(requested_view : UserInterface.Views) -> void:
	visible = requested_view == view
