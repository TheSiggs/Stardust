class_name PrototypeGenerator
extends Control
## Generator prototype generating stardust every second


## Refernece to timer
@export var timer : Timer
## Reference to button
@export var button : Button
## View Reference
@export var view : UserInterface.Views 
## Reference UI
@export var user_interface : UserInterface


## initialize label
func _ready() -> void:
	visible = false
	
	user_interface.navigation_requested.connect(_on_navigation_request)


## start timer and disable button on press
func start_generating_stardust() -> void:
	timer.start()
	button.disabled = true

## increment stardust
func create_stardust() -> void:
	HandlerStardust.ref.create_stardust(1)


## Trigers stardust generation
func _on_button_pressed():
	start_generating_stardust()

## Triggers stardust increment 
func _on_timer_timeout():
	create_stardust()

## Watch for nav requests
func _on_navigation_request(requested_view : UserInterface.Views) -> void:
	if requested_view == view:
		visible = true
		return
	
	visible = false
