class_name Game
extends Node
## Main game node

## Singleton reference
static var ref : Game

## Game data
var data  : Data

## Singleton check
func _singleton_check():
	if not ref:
		ref = self
		
		return
	queue_free()


## Game initialization
func _enter_tree() -> void:
	_singleton_check()
	data = Data.new()
	SaveSystem.load_data()

## Save when timer timesout
func _on_save_timer_timeout():
	SaveSystem.save_data()
