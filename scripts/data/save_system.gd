class_name SaveSystem
## Save manager

## File to save/load
const PATH : String = "user://save.tres"
const SHOULD_LOAD : bool = false

## Write game.ref.data to file
static func save_data() -> void:
	ResourceSaver.save(Game.ref.data, PATH)

## Loads data and override game.ref.data 
static func load_data() -> void:
	if not SHOULD_LOAD:
		return
	if ResourceLoader.exists(PATH):
		Game.ref.data = load(PATH)
