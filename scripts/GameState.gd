#GameState.gd
extends Node

#Time of the Day
enum TimeOfDay {
	MORNING,
	AFTERNOON,
	NIGHT
}

#Initial States
var current_time_of_day = TimeOfDay.MORNING
var energy = 100
var stress = 0
var study = 0
#var money = 0
var day = 1
