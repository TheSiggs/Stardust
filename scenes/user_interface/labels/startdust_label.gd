class_name LabelStardust
extends Label
## Displays the current amount of Stardust

## Connect signals
func _ready() -> void:
	update_text()
	HandlerStardust.ref.stardust_created.connect(update_text)
	HandlerStardust.ref.stardust_consumed.connect(update_text)

## Updates stardust text
func update_text(_qty : int = -1) -> void:
	var stardust : int = HandlerStardust.ref.get_stardust()
	if stardust:
		text = "Stardust Stardust : %s" % stardust
	else:
		text = ""
