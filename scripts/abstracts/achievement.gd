class_name Achievement
extends Node

signal achievement_completed
signal achievement_progressed

## Whether or not this achievement is compelted
var completed : bool = false

## Virtual function - returns title
func get_title() -> String:
	assert(false)
	return "Title not found"

## Virtual function - returns description
func get_description() -> String:
	assert(false)
	return "description not found"

## Virtual function - returns progress
func get_progress() -> float:
	assert(false)
	return -1

## Virtual function - returns progress goal
func get_progress_goal() -> float:
	assert(false)
	return -1
