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

signal nebula_effect_updated

signal effect_stardust_consumption_updated

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

## Total stardust generation effect
var effect_stardust_generation : int = 0

## Amount of stardust being consumed by all Nebula
var effect_stardust_consumed : int = 0

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
	
	calculate_effect_stardust_consumed()

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
	
	calculate_effect_stardust_consumed()
	
	nebula_created.emit()
	return Error.OK


## Updates the stardust attraction value of a single Nebula
func update_nebula_stardust_attraction_value(index : int, value : int) -> void:
	nebula[index].attraction_value = value
	Game.ref.data.nebula[index].attraction_value = value
	
	calculate_effect_stardust_consumed()


## Updates the ionized stardust release value of a single Nebula
func update_nebula_release_value(index : int, value : int) -> void:
	nebula[index].release_value = value
	Game.ref.data.nebula[index].release_value = value

## Cumulates all nebula effects into single prop
func calculate_nebula_effect_stardust_generation() -> void:
	var old_effect : int = effect_stardust_generation
	var new_effect : int = 0
	for this_nebula : Nebula in nebula:
		new_effect += this_nebula.effect_stardust_generation
	
	effect_stardust_generation = new_effect
	
	if new_effect != old_effect:
		nebula_effect_updated.emit()

## calculates total stardust consumption rate
func calculate_effect_stardust_consumed() -> void:
	var old_effect : int = effect_stardust_consumed
	var new_effect : int = 0
	for this_nebula : Nebula in nebula:
		new_effect += this_nebula.attraction_value
	
	effect_stardust_consumed = new_effect
	
	if effect_stardust_consumed != old_effect:
		effect_stardust_consumption_updated.emit()
