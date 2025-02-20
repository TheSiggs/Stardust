class_name UserInterface
extends Control
## Main class controlling the UI

## list of views
enum Views {
	UNIVERSE,
	CONSCIOUSNESS_CORE,
	NEBULA,
	SIFTING,
	ACHIEVEMENTS
}

## Emitted when something requests the nav.
signal navigation_requested(view : Views)

## Naivgate to universe view on launch
func _ready() -> void:
	navigation_requested.emit(Views.UNIVERSE)

## Trigered when CONSCIOUSNESS_CORE is ui link is clicked
func _on_consciousness_core_link_pressed() -> void:
	navigation_requested.emit(Views.CONSCIOUSNESS_CORE)

## Triggered wh nthe universe link button is clicked
func _on_universe_link_pressed() -> void:
	navigation_requested.emit(Views.UNIVERSE)

func _on_nebula_link_pressed() -> void:
	navigation_requested.emit(Views.NEBULA)

func _on_sifting_link_pressed() -> void:
	navigation_requested.emit(Views.SIFTING)


func _on_achievement_link_pressed() -> void:
	navigation_requested.emit(Views.ACHIEVEMENTS)
