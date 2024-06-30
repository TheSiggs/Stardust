class_name CompoNebula
extends VBoxContainer
## Displays the information of a Nebula

## References the label displaying the name
@export var label_name : Label

## References the label displaying the composition
@export var label_composition : RichTextLabel

## References the slider managing the consumption
@export var consumption_slider : HSlider

## Reference the Nebula to display
var nebula : Nebula

func _ready() -> void:
	update_component()
	nebula.composition_updated.connect(update_component)

## Update all nodes of the component
func update_component() -> void:
	update_label_name()
	update_label_composition()
	update_slider()

func update_label_name() -> void:
	label_name.text = nebula.given_name

func update_label_composition() -> void:
	var text = "Stardust: %s" % nebula.stardust
	label_composition.text = text

func update_slider() -> void:
	consumption_slider.max_value = 5
	consumption_slider.value = nebula.stardust_consumes


func _on_h_slider_value_changed(value : float) -> void:
	HandlerNebula.ref.update_nebula_stardust_consumption_value(nebula.data_index, int(value))
