extends Node

# Declare AudioStreamPlayer nodes here
var correct_sound = AudioStreamPlayer.new()
var wrong_sound = AudioStreamPlayer.new()
var game_win_sound = AudioStreamPlayer.new()
var confirm_action_sound = AudioStreamPlayer.new()
var cancel_action_sound = AudioStreamPlayer.new()
var door_open_sound = AudioStreamPlayer.new()
var door_close_sound = AudioStreamPlayer.new()
var class_start_sound = AudioStreamPlayer.new()
var sleep_sound = AudioStreamPlayer.new()
var study_sound = AudioStreamPlayer.new()

func _ready():
	# Initialize the AudioStreamPlayer nodes
	correct_sound.stream = load("res://assets/sounds/sound effect/correct.wav")
	wrong_sound.stream = load("res://assets/sounds/sound effect/wrong.wav")
	game_win_sound.stream=load("res://assets/sounds/sound effect/win.wav")
	confirm_action_sound.stream=load("res://assets/sounds/sound effect/confirm.wav")
	cancel_action_sound.stream=load("res://assets/sounds/sound effect/cancel.wav")
	door_open_sound.stream=load("res://assets/sounds/sound effect/door_open.wav")
	door_close_sound.stream=load("res://assets/sounds/sound effect/door_closed.wav")
	class_start_sound.stream=load("res://assets/sounds/sound effect/class.wav")
	sleep_sound.stream=load("res://assets/sounds/sound effect/sleep.wav")
	study_sound.stream = load("res://assets/sounds/sound effect/study_minigame/studying.wav")
	
	# Add them as children to ensure they are part of the scene tree
	add_child(correct_sound)
	add_child(wrong_sound)
	add_child(game_win_sound)
	add_child(confirm_action_sound)
	add_child(cancel_action_sound)
	add_child(door_open_sound)
	add_child(door_close_sound)
	add_child(class_start_sound)
	add_child(sleep_sound)
	add_child(study_sound)

# Function to play the correct sound
func play_correct_sound():
	correct_sound.play()

# Function to play the wrong sound
func play_wrong_sound():
	wrong_sound.play()

# Function to play the game win sound
func play_game_win_sound():
	game_win_sound.play()
	
# Function to play the game win sound
func play_confirm_action_sound():
	confirm_action_sound.play()
	
func play_cancel_action_sound():
	cancel_action_sound.play()
	
func play_door_open_sound():	
	door_open_sound.play()
	
func play_door_closed_sound():	
	door_close_sound.play()
	
func play_class_start_sound():
	class_start_sound.play()
	
func play_sleep_sound():
	sleep_sound.play()
	
func stop_all_sounds():
	correct_sound.stop()
	wrong_sound.stop()
	game_win_sound.stop()
	confirm_action_sound.play()
	cancel_action_sound.play()
	class_start_sound.play()

func play_studying_sound():
		study_sound.play()
