class_name PrototypeGenerator
extends Control
## Generator prototype generating stardust every second

## Reference to label
@export var label : Label
## Refernece to timer
@export var timer : Timer
## Reference to button
@export var button : Button

## stardust
var stardust : int

## initialize label
func _ready() -> void:
	update_label_text()

## start timer and disable button on press
func start_generating_stardust() -> void:
	timer.start()
	button.disabled = true

## increment stardust
func create_stardust() -> void:
	stardust += 1
	update_label_text()

## Set label
func update_label_text() -> void:
	label.text = "Stardust : %s" % stardust

## Trigers stardust generation
func _on_button_pressed():
	start_generating_stardust()

## Triggers stardust increment 
func _on_timer_timeout():
	create_stardust()
