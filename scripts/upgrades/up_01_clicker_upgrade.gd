class_name Up01ClickerUpgrade
extends Upgrade
## Upgrade 01 - increases stardust created by the clicker

## Load upgrade data
func _init() -> void: 
	level = Game.ref.data.up_01_level
	title = "Clicker Upgrade"
	base_cost = 5
	description = get_description()
	calculate_cost()

## Returns description
func get_description() -> String:
	var _description : String = "Increases the amount of stardust created by the Clicker"
	_description += "\n Effects: +1 Stardust / level"
	_description += "\n Cost: %s" % cost
	return _description

## Returns current cost
func calculate_cost() -> void:
	cost = int(base_cost * pow(1.5, level))


## Calculates whether an upgrade is able to be purchased
func can_afford() -> bool:
	return HandlerStardust.ref.get_stardust() >= cost

## Consumes stardust to level up
func level_up() -> void:
	var error : Error = HandlerStardust.ref.consume_stardust(cost)
	if not error:
		level += 1
		Game.ref.data.up_01_level = level
		calculate_cost()
		leveled_up.emit()
