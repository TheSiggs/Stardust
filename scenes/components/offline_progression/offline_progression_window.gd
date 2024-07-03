class_name OfflineProgressionComponent
extends TextureButton

func _on_pressed():
	queue_free()

func set_generated_stardust_value(qty : int) -> void:
	var text : String = "%s Stardust were generated while you were gone" % qty
	$ColorRect/Panel/MarginContainer/VBoxContainer/Body.text = text
