class_name CompoAchievement
extends Panel
## Achievement Component

var achievement  : Achievement

func inject_achievement_data(_achievement: Achievement) -> void: 
	achievement = _achievement
	(%Title as Label).text = achievement.get_title()
	(%Description as RichTextLabel).text = achievement.get_description()
	(%ProgressBar as ProgressBar).min_value = 0
	(%ProgressBar as ProgressBar).max_value = achievement.get_progress_goal()
	(%ProgressBar as ProgressBar).value = achievement.get_progress()
	(%Veil as ColorRect).visible = achievement.completed
	
	if not achievement.completed:
		achievement.achievement_completed.connect(_on_achievement_completed)
		achievement.achievement_progressed.connect(_on_achievement_progressed)

func _on_achievement_completed() -> void:
	(%ProgressBar as ProgressBar).value = achievement.get_progress()
	(%Veil as ColorRect).visible = achievement.completed
	achievement.achievement_completed.disconnect(_on_achievement_completed)
	achievement.achievement_progressed.disconnect(_on_achievement_progressed)

func _on_achievement_progressed() -> void:
	(%ProgressBar as ProgressBar).value = achievement.get_progress()
