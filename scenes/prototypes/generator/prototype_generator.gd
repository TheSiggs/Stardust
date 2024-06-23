class_name PrototypeGenerator
extends View
## Generator prototype generating stardust every second


## Refernece to timer
@export var timer : Timer
## Reference to button
@export var button : Button



## initialize label
func _ready() -> void:
	super()
	visible = false	

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
