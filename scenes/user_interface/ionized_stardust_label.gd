class_name LabelIonizedStardust
extends Label
## Displays the current amount of Stardust

## Connect signals
func _ready() -> void:
	update_text()
	HandlerIonizedStardust.ref.ionized_stardust_created.connect(update_text)
	HandlerIonizedStardust.ref.ionized_stardust_consumed.connect(update_text)

## Updates stardust text
func update_text(_qty : int = -1) -> void:
	var ionized_stardust : int = HandlerIonizedStardust.ref.get_ionized_stardust()
	if ionized_stardust:
		text = "Ionized Stardust : %s" % ionized_stardust
	else:
		text = ""
