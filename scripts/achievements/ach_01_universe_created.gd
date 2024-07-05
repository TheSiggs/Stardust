class_name Ach01UniverseCreated
extends Achievement

func _init() -> void:
	name = "Ach01UniverseCreated"
	completed = Game.ref.data.achievements.ach_01_universe_created
	
	if !completed:
		HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.connect(_on_achievement_completed)

## returns title
func get_title() -> String:
	return "Universe Creator"

## returns description
func get_description() -> String:
	return "Create your first Universe"

## returns progress
func get_progress() -> float:
	return float(completed)

## returns progress goal
func get_progress_goal() -> float:
	return 1

## Tracks achievement completion
func _on_achievement_completed() -> void:
	completed = true
	Game.ref.data.achievements.ach_01_universe_created = true
	achievement_completed.emit()
	HandlerCCUpgrades.ref.u_01_stardust_generation.leveled_up.disconnect(_on_achievement_completed)
