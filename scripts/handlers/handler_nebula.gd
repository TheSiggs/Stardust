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
		new_nebula.stardust_consumes = _nebula.stardust_consumes
		new_nebula.data_index = index
		
		timer.timeout.connect(new_nebula._on_consume_stardust)
		
		nebula.append(new_nebula)
		index += 1

## Get list of nebula
func get_all_nebula() -> Array[Nebula]:
	return nebula


## Create a new nebula and add it to the list
func create_nebula() -> void:
	var new_nebula : Nebula = Nebula.new()
	new_nebula.data_index = nebula.size()
	
	timer.timeout.connect(new_nebula._on_consume_stardust)
	nebula.append(new_nebula)
	
	var data_nebula : DataNebula = DataNebula.new()
	data_nebula.name = new_nebula.given_name
	data_nebula.stardust = new_nebula.stardust
	data_nebula.stardust_consumes = new_nebula.stardust_consumes
	Game.ref.data.nebula.append(data_nebula)
	
	nebula_created.emit()


## Updates the stardust consumption value of a single Nebula
func update_nebula_stardust_consumption_value(index : int, value : int) -> void:
	nebula[index].stardust_consumes = value
	Game.ref.data.nebula[index].stardust_consumes = value
