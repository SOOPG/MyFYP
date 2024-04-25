extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_button_newgame_pressed():
	# Reset Game state
	GameState.new_game()
	# Loading the home scene
	get_tree().change_scene_to_file("res://scenes/sceneHome.tscn")


func _on_button_tutorial_pressed():
	get_tree().change_scene_to_file("res://scenes/sceneTutorial.tscn")


func _on_button_exit_pressed():
	# Close the game
	get_tree().quit()  

func _on_button_volume_pressed():
	pass # Replace with function body.
