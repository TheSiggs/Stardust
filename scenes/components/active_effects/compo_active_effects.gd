extends VBoxContainer
## Displays the Acitve effects of the universe

## References the label to display the SPS (Stardust Per Second)
@export var stardust_per_second : RichTextLabel

func _ready() -> void:
	_connect_signals()
	_update_stardust_per_second()

func _connect_signals() -> void:
	HandlerStardustGenerator.ref.generator_power_calculated.connect(_on_stardust_generator_power_calculated)

## Updates the stardust per second displayed
func _update_stardust_per_second() -> void:
	var text : String = "[b]Stardust/s:[/b] %s" % HandlerStardustGenerator.ref.generator_power
	stardust_per_second.text = text

## Triggered on generator_power_calculated signal emitted
func _on_stardust_generator_power_calculated() -> void:
	_update_stardust_per_second()
