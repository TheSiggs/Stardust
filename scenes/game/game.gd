class_name Game
extends Node
## Main game node

## Singleton reference
static var ref : Game

## Game data
var data  : Data

## Reference to the user interface packed scene
@export var scene_user_interface : PackedScene

## Reference to offline progression scene
@export var scene_offine_progression : PackedScene

## Singleton check
func _singleton_check() -> void:
	if not ref:
		ref = self
		return
	queue_free()


func _ready() -> void:
	var node_ui : UserInterface = scene_user_interface.instantiate() as UserInterface
	add_child(node_ui)
	
	offline_progression()


## Game initialization
func _enter_tree() -> void:
	_singleton_check()
	data = Data.new()
	SaveSystem.load_data()

## Save when timer timesout
func _on_save_timer_timeout() -> void:
	SaveSystem.save_data()

func offline_progression() -> void:
	var offline_time : int = SaveSystem.offline_time()
	if offline_time <= 0:
		return
	var generated_stardust : int = HandlerStardustGenerator.ref.generator_power * offline_time
	HandlerStardust.ref.create_stardust(generated_stardust)
	
	var node : OfflineProgressionComponent = scene_offine_progression.instantiate() as OfflineProgressionComponent
	node.set_generated_stardust_value(generated_stardust)
	add_child(node)
