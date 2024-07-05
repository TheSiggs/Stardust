class_name Ach02StardustCreator
extends Achievement

var progress_value : int = 0
var goal : int = 100

func _init() -> void:
	name = "Ach01UniverseCreated"
	completed = Game.ref.data.achievements.ach_02_stardust_creator
	progress_value = Game.ref.data.achievements.ach_02_progress_value
	
	if !completed:
		HandlerStardust.ref.stardust_created.connect(_on_achievement_progressed)

## returns title
func get_title() -> String:
	return "Stardust Creator"

## returns description
func get_description() -> String:
	return "Create Stardust!"

## returns progress
func get_progress() -> float:
	return progress_value

## returns progress goal
func get_progress_goal() -> float:
	return 100

## Tracks achievement completion
func _on_achievement_completed() -> void:
	achievement_completed.emit()
	completed = true
	Game.ref.data.achievements.ach_02_stardust_creator = true
	HandlerStardust.ref.stardust_created.disconnect(_on_achievement_progressed)

## Tracks on achievement progression
func _on_achievement_progressed(qty : int) -> void:
	progress_value += qty
	if progress_value > goal:
		progress_value = goal
	
	Game.ref.data.achievements.ach_02_progress_value = progress_value
	
	if progress_value == goal:
		_on_achievement_completed()
	
	achievement_progressed.emit()
