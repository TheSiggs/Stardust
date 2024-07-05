class_name ViewAchievement
extends View

@export var packed_achievement_component : PackedScene

func _ready() -> void:
	super()
	_init_children()

func _init_children() -> void:
	for achievement : Achievement in HandlerAchievements.ref.get_all_achievements():
		_create_achievement_child(achievement)

func _create_achievement_child(achievement : Achievement) -> void:
	var achievment_component : CompoAchievement = (
		packed_achievement_component.instantiate() as CompoAchievement
	)
	
	achievment_component.inject_achievement_data(achievement)
	%AchievementList.add_child(achievment_component)
