class_name PrototypeUpgrades
extends Control
## Prototpye of a view display upgrades

## View Reference
@export var view : UserInterface.Views 
## Reference UI
@export var user_interface : UserInterface


## Initilize visibility
func _ready() -> void:
	visible = true
	user_interface.navigation_requested.connect(_on_navigation_request)

## Watch for nav requests
func _on_navigation_request(requested_view : UserInterface.Views) -> void:
	if requested_view == view:
		visible = true
		return
	
	visible = false
