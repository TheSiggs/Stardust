class_name ViewNebula
extends View
## Displays nebula view

## Area to add new Nebula
@export var main_list : VBoxContainer

## References the scene of  the Nebula element
@export var scene_nebula : PackedScene

## Reference of the handler
@onready var handler : HandlerNebula = HandlerNebula.ref

@export var create_nebula_button : Button

## Init the view settings
func _ready() -> void:
	super()
	_generate_nebula()
	connect_signals()

func connect_signals() -> void:
	handler.nebula_created.connect(_generate_newest_nebula)
	HandlerCCUpgrades.ref.upgrade_leveled_up.connect(update_create_nebula_button)

## Attempt to create a nebula
func _on_button_pressed() -> void:
	handler.create_nebula()
	update_create_nebula_button()

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


func update_create_nebula_button(_upgrade : Upgrade = null) -> void:
	create_nebula_button.disabled = handler.nebula.size() == handler.max_nebula_count
	
	if create_nebula_button.disabled:
		create_nebula_button.text = "Upgrade Nebula Capacity To Create More Nebula"
	else:
		create_nebula_button.text = "Create a New Nebula"
