class_name SaveSystem
## Save manager

## File to save/load
const PATH : String = "user://save.tres"
const SHOULD_LOAD : bool = false
const MAX_OFFLINE_TIME : int = 3600 * 24

## Write game.ref.data to file
static func save_data() -> void:
	Game.ref.data.save_time = int(Time.get_unix_time_from_system())
	ResourceSaver.save(Game.ref.data, PATH)

## Loads data and override game.ref.data 
static func load_data() -> void:
	if not SHOULD_LOAD:
		return
	if ResourceLoader.exists(PATH):
		Game.ref.data = load(PATH)

static func offline_time() -> int:
	if Game.ref.data.save_time <= 0:
		return 0
	
	var save_time : int = Game.ref.data.save_time
	var load_time : int = int(Time.get_unix_time_from_system())
	if load_time <= save_time:
		return 0
	
	var delta_time : int = load_time - save_time
	
	if delta_time > MAX_OFFLINE_TIME:
		delta_time = MAX_OFFLINE_TIME
	
	return delta_time
