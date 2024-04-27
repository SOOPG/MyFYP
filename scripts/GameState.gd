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
var money = 51
var day = 1

var playerHasDoneHangout = false
var playerHasDoneJob = false
var playerHasDoneStudy = false

var sleep_fact_index = 0
var hangout_fact_index = 0
var study_fact_index = 0
var work_fact_index = 0

func modify_player_stats(energyModifer,stressModifer,studyModifer):
	energy = energy + energyModifer
	stress = stress + stressModifer
	study = study + studyModifer
	
	energy = clamp(energy, 0, 100)
	stress = clamp(stress, 0, 100)
	study = clamp(study, 0, 100)
	

func modify_player_money(moneyModifer):
	money = money + moneyModifer
	money = clamp(money, 0, 200)

func reset_player_interaction():
	playerHasDoneHangout = false
	playerHasDoneJob = false
	playerHasDoneStudy = false

func pay_rental(rentalModifer):
	money = money + rentalModifer
	

# New Game
func new_game():
# 	Reset time of day
	current_time_of_day = TimeOfDay.MORNING
	
	# Reset player stats
	energy = 100
	stress = 0
	study = 0
	money = 51 
	day = 1

	# Reset player interactions
	playerHasDoneHangout = false
	playerHasDoneJob = false
	playerHasDoneStudy = false

	# Reset fact indices
	sleep_fact_index = 0
	hangout_fact_index = 0
	study_fact_index = 0
	work_fact_index = 0
