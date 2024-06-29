class_name Game
extends Node
## Main game node

## Singleton reference
static var ref : Game

## Game data
var data  : Data

## Reference to the user interface packed scene
@export var scene_user_interface : PackedScene

## Singleton check
func _singleton_check() -> void:
	if not ref:
		ref = self
		return
	queue_free()


func _ready() -> void:
	var node_ui : UserInterface = scene_user_interface.instantiate() as UserInterface
	add_child(node_ui)

## Game initialization
func _enter_tree() -> void:
	_singleton_check()
	data = Data.new()
	SaveSystem.load_data()

## Save when timer timesout
func _on_save_timer_timeout():
	SaveSystem.save_data()
