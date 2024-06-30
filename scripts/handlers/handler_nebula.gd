class_name HandlerNebula
extends Node
## Manage Nebula

## Singleton reference
static var ref : HandlerNebula

## Singleton check
func _singleton_check() -> void:
	if not ref:
		ref = self
		return
	queue_free()

## Game initialization
func _enter_tree() -> void:
	_singleton_check()

# ------------------------------------------

signal nebula_created

## Reference to the timer
@export var timer : Timer

## List of Nebula
var nebula : Array[Nebula] = []

## Maximum amount of nebulas which can exist
var max_nebula_count : int = 1

## Nebula Minimum attraction value 
var min_attraction_value : int = 1
## Nebula Maximum attraction value 
var max_attraction_value : int = 5

## Nebula Minimum release value 
var min_release_value : int = 1
## Nebula Maximum release value 
var max_release_value : int = 5

## load nebula
func _ready() -> void:
	pass

## Load nebula from data
func load_nebula() -> void:
	if Game.ref.data.nebula.size() == 0:
		return
	
	var index : int = 0
	for _nebula : DataNebula in Game.ref.data.nebula:
		var new_nebula : Nebula = Nebula.new() 
		new_nebula.given_name = _nebula.name
		new_nebula.stardust = _nebula.stardust
		new_nebula.ionized_stardust = _nebula.ionized_stardust
		new_nebula.attraction_value = _nebula.attraction_value
		new_nebula.release_value = _nebula.release_value
		new_nebula.data_index = index
		
		timer.timeout.connect(new_nebula._on_nebula_timer_timeout)
		
		nebula.append(new_nebula)
		index += 1

## Get list of nebula
func get_all_nebula() -> Array[Nebula]:
	return nebula


## Create a new nebula and add it to the list
func create_nebula() -> Error:
	if nebula.size() >= max_nebula_count:
		return Error.FAILED
	
	var new_nebula : Nebula = Nebula.new()
	new_nebula.data_index = nebula.size()
	
	timer.timeout.connect(new_nebula._on_nebula_timer_timeout)
	nebula.append(new_nebula)
	
	var data_nebula : DataNebula = DataNebula.new()
	data_nebula.name = new_nebula.given_name
	data_nebula.stardust = new_nebula.stardust
	data_nebula.attraction_value = new_nebula.attraction_value
	Game.ref.data.nebula.append(data_nebula)
	
	nebula_created.emit()
	return Error.OK


## Updates the stardust attraction value of a single Nebula
func update_nebula_stardust_attraction_value(index : int, value : int) -> void:
	nebula[index].attraction_value = value
	Game.ref.data.nebula[index].attraction_value = value


## Updates the ionized stardust release value of a single Nebula
func update_nebula_release_value(index : int, value : int) -> void:
	nebula[index].release_value = value
	Game.ref.data.nebula[index].release_value = value
