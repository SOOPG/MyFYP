#Time of the Day
extends Node

enum TimeOfDay {
	MORNING,
	AFTERNOON,
	NIGHT
}
#Time Related State, Begin Game with Morning
var current_time_of_day = TimeOfDay.MORNING
