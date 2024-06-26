extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.stop_all_sounds()
	AudioManager.play_mainmenu_music()

func _on_button_newgame_pressed():
	AudioManager.play_confirm_action_sound()
	# Reset Game state
	GameState.new_game()
	AudioManager.stop_all_music()
	# Loading the home scene
	get_tree().change_scene_to_file("res://scenes/sceneHome.tscn")


func _on_button_tutorial_pressed():
	AudioManager.play_confirm_action_sound()
	get_tree().change_scene_to_file("res://scenes/sceneTutorial.tscn")


func _on_button_exit_pressed():
	# Close the game
	get_tree().quit()  
