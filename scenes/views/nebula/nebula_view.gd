class_name ViewNebula
extends View
## Displays nebula view

## Area to add new Nebula
@export var main_list : VBoxContainer

## References the scene of  the Nebula element
@export var scene_nebula : PackedScene

## Reference of the handler
@onready var handler : HandlerNebula = HandlerNebula.ref

## Init the view settings
func _ready() -> void:
	super()
	_generate_nebula()
	handler.nebula_created.connect(_generate_newest_nebula)


## Attempt to create a nebula
func _on_button_pressed() -> void:
	handler.create_nebula()

## Generates all nebula from handler
func _generate_nebula() -> void:
	if handler.nebula.size() == 0:
		return
	
	for nebula : Nebula in handler.nebula:
		var new_node : CompoNebula = scene_nebula.instantiate() as CompoNebula
		new_node.nebula = nebula
		main_list.add_child(new_node)

## Generate the newest node
func _generate_newest_nebula() -> void:
	var new_node : CompoNebula = scene_nebula.instantiate() as CompoNebula
	new_node.nebula = handler.nebula[handler.nebula.size() - 1]
	main_list.add_child(new_node)
