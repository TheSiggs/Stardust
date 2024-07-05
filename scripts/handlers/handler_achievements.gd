class_name HandlerAchievements
extends Node
## Manages Stardust resources

## Singleton reference
static var ref : HandlerAchievements

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	queue_free()

# ------------------------------------------


@onready var ach_01_universe_created : Ach01UniverseCreated = Ach01UniverseCreated.new()
@onready var ach_02_stardust_creator : Ach02StardustCreator = Ach02StardustCreator.new()

func _ready():
	_init_achievements()

func _init_achievements() -> void:
	ach_01_universe_created = Ach01UniverseCreated.new()
	add_child(ach_01_universe_created)

func get_all_achievements() -> Array[Achievement]:
	return [
	ach_01_universe_created,
	ach_02_stardust_creator
]
