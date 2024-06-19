class_name PrototypeGenerator
extends Control


@export var label : Label
@export var timer : Timer
@export var button : Button

var stardust : int

func _ready() -> void:
	update_label_text()

func start_generating_stardust() -> void:
	timer.start()
	button.disabled = true

func create_stardust() -> void:
	stardust += 1
	update_label_text()

func update_label_text() -> void:
	label.text = "Stardust : %s" % stardust

func _on_button_pressed():
	start_generating_stardust()


func _on_timer_timeout():
	create_stardust()
