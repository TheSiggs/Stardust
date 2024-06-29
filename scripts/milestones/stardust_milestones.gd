class_name MilestoneStardust
extends Node
## Generate Consciousness Core every X amount of stardust being created

## Emitted when the Milestone progress has changed
signal progressed

## Emitted when a new milestone is created
signal new_milestone_created

## Stardust required to crated next CC
var stardust_goal : int = -1
## Stardust generated in the last milestone
var stardust_progress : int = -1
## Reference to universe data
var universe : DataUniverse


func _init() -> void:
	universe = Game.ref.data.universe
	HandlerStardust.ref.stardust_created.connect(_on_stardust_creation)
	init_new_milestone(universe.stardust_milestone_progress)

## init milestone when previous is completed
func init_new_milestone(transfered_progress : int = 0) -> void:
	if universe.consciousness_core == 0:
		stardust_goal = 4
	else:
		stardust_goal = universe.consciousness_core * 8
	
	stardust_progress = transfered_progress
	universe.stardust_milestone_progress = stardust_progress
	new_milestone_created.emit()

## Checks for milestone completion
func check_for_completion() -> void:
	if stardust_progress < stardust_goal:
		return
	
	var stardust_excess : int = stardust_progress - stardust_goal
	HandlerConsciousnessCore.ref.create_concsiousness_core(1)
	
	init_new_milestone(stardust_excess)
	check_for_completion()

## Progresses the milestone on creation
func _on_stardust_creation(qty : int) -> void:
	stardust_progress += qty
	universe.stardust_milestone_progress = stardust_progress
	
	progressed.emit()
	check_for_completion()
