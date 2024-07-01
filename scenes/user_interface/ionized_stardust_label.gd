class_name LabelIonizedStardust
extends Label
## Displays the current amount of Stardust

var show_label : bool = HandlerIonizedStardust.ref.get_ionized_stardust() > 0

## Connect signals
func _ready() -> void:
	update_text()
	HandlerIonizedStardust.ref.ionized_stardust_created.connect(update_text)
	HandlerIonizedStardust.ref.ionized_stardust_consumed.connect(update_text)

## Updates stardust text
func update_text(_qty : int = -1) -> void:
	var ionized_stardust : int = HandlerIonizedStardust.ref.get_ionized_stardust()
	if ionized_stardust || show_label:
		show_label = true
		text = "Ionized Stardust : %s" % ionized_stardust
	else:
		text = ""
