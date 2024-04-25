extends CanvasLayer

@onready var win_screen = $GameWin
@onready var lose_screen = $GameOverStudy
@onready var trophy_button = $GameWin/trophyButton
@onready var game_win_button = $winButton
@onready var backdrop = $CongratulationPlayer/colorRect
@onready var creditText = $CongratulationPlayer/creditText
@onready var your_score = $CongratulationPlayer/yourScore
@onready var player_score = $CongratulationPlayer/playerScore

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Initial State
	win_screen.visible = false
	lose_screen.visible = false
	trophy_button.visible = true
	game_win_button.visible = false
	backdrop.visible = false
	creditText.visible = false
	your_score.visible = false
	player_score.visible = false
	
	
	# If player has > 60 study, win 
	if GameState.study > 60:
		# Show Winning Screen
		win_screen.visible = true
	# Else player fails, 
	else:
			# Show Losing Screen
		lose_screen.visible = true

func _on_trophy_button_pressed():
	trophy_button.visible = false
	# Set player score
	player_score.text = str(GameState.study)
	
	# Show backdrop
	show_backdrop_text()
	
	# Play the animation
	$CongratulationPlayer.play("congratulation")

func _on_congratulation_player_animation_finished(anim_name):
	game_win_button.visible=true

func _on_gamewin_button_pressed():
	get_tree().change_scene_to_file("res://scenes/sceneMainMenu.tscn")

#Game Over
func _on_gameover_from_study_button_pressed():
	get_tree().change_scene_to_file("res://scenes/sceneMainMenu.tscn")

func show_backdrop_text():
	backdrop.visible = true
	creditText.visible = true
	your_score.visible = true
	player_score.visible = true
