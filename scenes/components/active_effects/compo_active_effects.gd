extends VBoxContainer
## Displays the Acitve effects of the universe

## References the label to display the SPS (Stardust Per Second)
@export var stardust_per_second : RichTextLabel

func _ready() -> void:
	_connect_signals()
	_update_active_effects()

func _connect_signals() -> void:
	HandlerStardustGenerator.ref.generator_power_calculated.connect(_on_stardust_generator_power_calculated)
	HandlerNebula.ref.effect_stardust_consumption_updated.connect(_on_effect_nebula_stardust_consumption_updated)

## Updates the active effects display
func _update_active_effects() -> void:
	var text : String = "[b]Stardust/s:[/b] %s" % HandlerStardustGenerator.ref.generator_power
	if HandlerNebula.ref.effect_stardust_consumed:
		text += "\n[b]Nebula Stardust Consumption:[/b] %s" % HandlerNebula.ref.effect_stardust_consumed
	stardust_per_second.text = text

## Triggered on generator_power_calculated signal emitted
func _on_stardust_generator_power_calculated() -> void:
	_update_active_effects()

## Triggered when Nebulas' stardust consumption is updated
func _on_effect_nebula_stardust_consumption_updated() -> void:
	_update_active_effects()
