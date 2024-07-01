class_name LabelLiquidStardust
extends Label
## Displays the current amount of Stardust

## Connect signals
func _ready() -> void:
	update_text()
	HandlerLiquidStardust.ref.liquid_stardust_consumed.connect(update_text)
	HandlerLiquidStardust.ref.liquid_stardust_created.connect(update_text)


## Updates stardust text
func update_text(_qty : int = -1) -> void:
	var liquid_stardust : int = HandlerLiquidStardust.ref.get_liquid_stardust()
	if liquid_stardust:
		text = "Liquid Stardust: %s" % liquid_stardust
	else:
		text = ""
