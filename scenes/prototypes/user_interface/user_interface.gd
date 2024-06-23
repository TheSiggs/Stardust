class_name UserInterface
extends Control
## Main class controlling the UI

## list of views
enum Views {
	PROTOTYPE_GENERATOR,
	PROTOTYPE_CLICKER
}

## Emitted when something requests the nav.
signal navigation_requested(view : Views)


## Trigered when prototype generator is ui link is clicked
func _on_prototype_generator_link_pressed():
	navigation_requested.emit(Views.PROTOTYPE_GENERATOR)

## Trigered when prototype clicker is ui link is clicked
func _on_prototype_clicker_link_pressed():
	navigation_requested.emit(Views.PROTOTYPE_CLICKER)

