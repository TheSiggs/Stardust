class_name UserInterface
extends Control
## Main class controlling the UI

## list of views
enum Views {
	PROTOTYPE_GENERATOR,
	PROTOTYPE_CLICKER,
	PROTOTYPE_UPGRADES,
	CONSCIOUSNESS_CORE
}

## Emitted when something requests the nav.
signal navigation_requested(view : Views)


## Trigered when prototype generator is ui link is clicked
func _on_prototype_generator_link_pressed() -> void:
	navigation_requested.emit(Views.PROTOTYPE_GENERATOR)

## Trigered when prototype clicker is ui link is clicked
func _on_prototype_clicker_link_pressed() -> void:
	navigation_requested.emit(Views.PROTOTYPE_CLICKER)

## Trigered when prototype clicker is ui link is clicked
func _on_prototype_upgrades_link_pressed() -> void:
	navigation_requested.emit(Views.PROTOTYPE_UPGRADES)

## Trigered when CONSCIOUSNESS_CORE is ui link is clicked
func _on_consciousness_core_link_pressed():
	navigation_requested.emit(Views.CONSCIOUSNESS_CORE)
