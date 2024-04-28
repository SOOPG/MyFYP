extends CanvasLayer

func dispMsgToClass(label: Label, message: String, duration: float):
	if not label:
		print("Label node is not valid.")
		return

	label.text = message  # Set the message text passed to the function
	label.visible = true  # Make the label visible

	await get_tree().create_timer(3).timeout
	label.visible = false  # Hide the label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_return_button_pressed():
	AudioManager.play_door_closed_sound()
	get_tree().change_scene_to_file("res://scenes/sceneHome.tscn")


func _on_hangout_button_pressed():
	if GameState.playerHasDoneHangout == true:
		dispMsgToClass($statCheckerMsg, "I've done hangout already...", 3.0)
	elif GameState.money < 3:
		dispMsgToClass($statCheckerMsg, "I dont have enough money...", 3.0)
	elif GameState.energy < 30:
		#Show a text to player too tired
		dispMsgToClass($statCheckerMsg, "I'm too tired...", 3.0)
	else:
		AudioManager.play_confirm_action_sound()
		get_tree().change_scene_to_file("res://scenes/sceneLocationHangout.tscn")

func _on_work_button_pressed():
	if GameState.playerHasDoneJob == true:
		dispMsgToClass($statCheckerMsg, "I've done my job already...", 3.0)
	elif GameState.energy < 40:
		#Show a text to player too tired
		dispMsgToClass($statCheckerMsg, "I'm too tired...", 3.0)
	elif GameState.stress > 60:
		#Show a text to player too tired
		dispMsgToClass($statCheckerMsg, "I'm too stress...", 3.0)	
	else:
		AudioManager.play_confirm_action_sound()
		get_tree().change_scene_to_file("res://scenes/sceneWorkMinigame.tscn")

func _on_home_button_pressed():
	AudioManager.play_door_closed_sound()
	get_tree().change_scene_to_file("res://scenes/sceneHome.tscn")
