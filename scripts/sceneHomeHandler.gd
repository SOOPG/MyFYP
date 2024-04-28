#sceneHomeHandler
extends CanvasLayer

@onready var room_sprite = $room
@onready var bed_button = $BedButton
@onready var bed_hover_icon = $BedButton/bed_hover
@onready var study_button = $StudyButton
@onready var study_hover_icon = $StudyButton/study_hover
@onready var door_button = $DoorButton
@onready var door_hover_icon = $DoorButton/door_hover
@onready var energy_ui = $ColorRect/HBoxContainer/energy_level
@onready var stress_ui = $ColorRect/HBoxContainer/stress_level
@onready var study_ui = $ColorRect/HBoxContainer/study_level
@onready var calandar_ui = $ColorRect/HBoxContainer/day
@onready var money_ui = $ColorRect/Money
@onready var sleep_fact_scene = $sleepAnimationPlayer/sleepFact
@onready var gameover_stress_scene = $GameOverStress
@onready var gameover_rent_scene = $GameOverRent

var stress_facts = [
	"res://assets/scenes/stress facts/sleep/sleep_facts_1.png",
	"res://assets/scenes/stress facts/sleep/sleep_facts_2.png",
	"res://assets/scenes/stress facts/sleep/sleep_facts_3.png",
	"res://assets/scenes/stress facts/sleep/sleep_facts_4.png",
	"res://assets/scenes/stress facts/sleep/sleep_facts_5.png",
	"res://assets/scenes/stress facts/sleep/sleep_facts_6.png",
	"res://assets/scenes/stress facts/sleep/sleep_facts_7.png",
	]
	
# Member variable to keep track of the last shown fact index
var fact_index = 0

# To Update the Room based on the time of the day
func update_room_to_time():
	match GameState.current_time_of_day:
		GameState.TimeOfDay.MORNING:
			room_sprite.texture = preload("res://assets/scenes/apartment/room_base_time_1.png")
		GameState.TimeOfDay.AFTERNOON:
			room_sprite.texture = preload("res://assets/scenes/apartment/room_base_time_2.png")
		GameState.TimeOfDay.NIGHT:
			room_sprite.texture = preload("res://assets/scenes/apartment/room_base_time_3.png")

#To Update the Energy
func update_energy_display(modifier :int):
	GameState.energy = GameState.energy + modifier
	# Determine the texture to load based on the energy range
	if GameState.energy < 25:
		energy_ui.texture = load("res://assets/sprites/ui/status_bars/energy/energy_level_0.png")
	elif GameState.energy < 50:
		energy_ui.texture = load("res://assets/sprites/ui/status_bars/energy/energy_level_25.png")
	elif GameState.energy < 75:
		energy_ui.texture = load("res://assets/sprites/ui/status_bars/energy/energy_level_50.png")
	elif GameState.energy < 100:
		energy_ui.texture = load("res://assets/sprites/ui/status_bars/energy/energy_level_75.png")
	elif GameState.energy == 100:
		energy_ui.texture = load("res://assets/sprites/ui/status_bars/energy/energy_level_100.png")

#To Update the Stress
func update_stress_display(modifier :int):
	GameState.stress = GameState.stress + modifier
	# Determine the texture to load based on the energy range
	if GameState.stress < 25:
		stress_ui.texture = load("res://assets/sprites/ui/status_bars/stress/stress_level_0.png")
	elif GameState.stress < 50:
		stress_ui.texture = load("res://assets/sprites/ui/status_bars/stress/stress_level_25.png")
	elif GameState.stress < 75:
		stress_ui.texture = load("res://assets/sprites/ui/status_bars/stress/stress_level_50.png")
	elif GameState.stress < 100:
		stress_ui.texture = load("res://assets/sprites/ui/status_bars/stress/stress_level_75.png")
	elif GameState.stress == 100:
		stress_ui.texture = load("res://assets/sprites/ui/status_bars/stress/stress_level_100.png")

#To Update the Study
func update_study_display(modifier :int):
	GameState.study = GameState.study + modifier
	# Determine the texture to load based on the energy range
	if GameState.study < 25:
		study_ui.texture = load("res://assets/sprites/ui/status_bars/study/study_level_0.png")
	elif GameState.study < 50:
		study_ui.texture = load("res://assets/sprites/ui/status_bars/study/study_level_25.png")
	elif GameState.study < 75:
		study_ui.texture = load("res://assets/sprites/ui/status_bars/study/study_level_50.png")
	elif GameState.study < 100:
		study_ui.texture = load("res://assets/sprites/ui/status_bars/study/study_level_75.png")
	elif GameState.study == 100:
		study_ui.texture = load("res://assets/sprites/ui/status_bars/study/study_level_100.png")
#To Update the Calandar
func update_calandar_display(increment :int):
	GameState.day = GameState.day + increment
		# Determine the texture to load based on the energy range
	match GameState.day:
		1:
			calandar_ui.texture=load("res://assets/sprites/ui/status_bars/calendar/day_1.png")
		2:
			calandar_ui.texture=load("res://assets/sprites/ui/status_bars/calendar/day_2.png")
		3:
			calandar_ui.texture=load("res://assets/sprites/ui/status_bars/calendar/day_3.png")
		4:
			calandar_ui.texture=load("res://assets/sprites/ui/status_bars/calendar/day_4.png")
		5:
			calandar_ui.texture=load("res://assets/sprites/ui/status_bars/calendar/day_5.png")
		6:
			calandar_ui.texture=load("res://assets/sprites/ui/status_bars/calendar/day_6.png")
		7:
			calandar_ui.texture=load("res://assets/sprites/ui/status_bars/calendar/day_7.png")

#To Update the Money
func update_money_display():
	money_ui.text = str(GameState.money)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	AudioManager.play_room_music()
	update_room_to_time()
	update_energy_display(0)
	update_stress_display(0)
	update_study_display(0)
	update_calandar_display(0)
	update_money_display()

	# Connect the mouse_entered and mouse_exited signals
	bed_button.mouse_entered.connect(self._on_bed_mouse_entered)
	bed_button.mouse_exited.connect(self._on_bed_mouse_exited)
	study_button.mouse_entered.connect(self._on_study_mouse_entered)
	study_button.mouse_exited.connect(self._on_study_mouse_exited)
	door_button.mouse_entered.connect(self._on_door_mouse_entered)
	door_button.mouse_exited.connect(self._on_door_mouse_exited)

func _process(delta):
	#Check if player's stress >= 100
	if GameState.stress >= 100:
		AudioManager.stop_all_music()
		AudioManager.play_gameover_sound()
		gameover_stress_scene.visible = true

#Function For Displaying User Messages
func dispMsgToClass(label: Label, message: String, duration: float):
	if not label:
		print("Label node is not valid.")
		return

	label.text = message  # Set the message text passed to the function
	label.visible = true  # Make the label visible

	await get_tree().create_timer(3).timeout
	label.visible = false  # Hide the label

#Hover Effect
func _on_bed_mouse_entered():
	bed_hover_icon.visible = true
func _on_bed_mouse_exited():
	bed_hover_icon.visible = false
func _on_study_mouse_entered():
	study_hover_icon.visible = true
func _on_study_mouse_exited():
	study_hover_icon.visible = false
func _on_door_mouse_entered():
	door_hover_icon.visible = true
func _on_door_mouse_exited():
	door_hover_icon.visible = false

#Player interact with bed
func _on_bed_button_pressed():
	if GameState.current_time_of_day == GameState.TimeOfDay.MORNING:
		AudioManager.play_cancel_action_sound()
		#If morning, notify player that they cant sleep now
		dispMsgToClass($Message, "I can't sleep now...", 3.0)
	else:
		if GameState.energy>60 and not GameState.current_time_of_day == GameState.TimeOfDay.NIGHT and not GameState.current_time_of_day == GameState.TimeOfDay.AFTERNOON:
			AudioManager.play_cancel_action_sound()
			#If morning, notify player that they cant sleep now
			dispMsgToClass($Message, "I'm not tired...", 3.0)
		else:
			AudioManager.stop_all_music()
			AudioManager.play_sleep_sound()
			#Sleep Animation
			sleepAnimationPlayer()

#Player interact with study table
func _on_study_button_pressed():
	if GameState.current_time_of_day == GameState.TimeOfDay.MORNING and GameState.day != 7:
		#If morning, notify player that they have to attend class
		AudioManager.play_cancel_action_sound()
		dispMsgToClass($Message, "I need to attend class first...", 3.0)
	elif GameState.energy < 40:
		AudioManager.play_cancel_action_sound()
			#If too tired, notify player
		dispMsgToClass($Message, "I'm too tired...", 3.0)
	elif GameState.stress > 50:
		AudioManager.play_cancel_action_sound()
			#If too stress, notify player
		dispMsgToClass($Message, "I'm too stress out...", 3.0)
	elif GameState.playerHasDoneStudy == true:
		AudioManager.play_cancel_action_sound()
		#If already studied, notify the player
		dispMsgToClass($Message, "I already studied for today...", 3.0)
	elif GameState.current_time_of_day == GameState.TimeOfDay.MORNING and GameState.day == 7:
		AudioManager.play_cancel_action_sound()
		#If already stress, notify player
		dispMsgToClass($Message, "I have an exam today...", 3.0)
	else:
		AudioManager.stop_all_music()
		AudioManager.play_confirm_action_sound()
		#Go to the study scene
		get_tree().change_scene_to_file("res://scenes/sceneStudyMinigame.tscn")

#Player interact with door
func _on_door_button_pressed():
	# If morning 
	if GameState.current_time_of_day == GameState.TimeOfDay.MORNING:
		# If not final day
		if GameState.day != 7:
			AudioManager.stop_all_music()
			AudioManager.play_door_open_sound()
			# Attend class when clicked on door
			$attendClassAnimationPlayer/sceneClassroom.visible = true
			AudioManager.play_class_start_sound()
			$attendClassAnimationPlayer.play("attendClass")
			# Decrease Energy, Increase Stress, Increase Study 
			GameState.modify_player_stats(-13,15,3)
			update_energy_display(0)
			update_stress_display(0)
			update_study_display(0)
			# If Last day, play ending
		elif GameState.day == 7:
			AudioManager.stop_all_music()
			get_tree().change_scene_to_file("res://scenes/sceneEnding.tscn")
			
	# If night, too late to go out
	elif GameState.current_time_of_day == GameState.TimeOfDay.NIGHT:
		AudioManager.play_cancel_action_sound()
		dispMsgToClass($Message, "It's too late to go out now...", 3.0)
	else:
		AudioManager.play_door_open_sound()
		# Allow Player to go to the selector menu
		get_tree().change_scene_to_file("res://scenes/sceneLocationSelectorMenu.tscn")

func _on_attendClassAnimationFinished(anim_name):
	if anim_name == "attendClass":
		AudioManager.play_room_music()
		# Hide the classroom sprite
		$attendClassAnimationPlayer/sceneClassroom.visible = false
		# Change the time to Afternoon
		GameState.current_time_of_day = GameState.TimeOfDay.AFTERNOON
		update_room_to_time()

func sleepAnimationPlayer():
	if GameState.sleep_fact_index< stress_facts.size():
		# Load the texture for the next fact
		var fact_texture = load(stress_facts[GameState.sleep_fact_index])
		# Set the sprite texture to the next fact
		sleep_fact_scene.texture = fact_texture

	#Play animation
	$sleepAnimationPlayer/sleepFact.visible = true
	$sleepAnimationPlayer.play("sleep")

func _on_sleep_animation_player_animation_finished(anim_name):
	if anim_name == "sleep":
		#Check if player has less than rental money
		if GameState.money < 25:
			AudioManager.stop_all_music()
			AudioManager.play_gameover_sound()
			gameover_rent_scene.visible = true
		else:
			AudioManager.play_room_music()
			# Randomize sleep facts
			GameState.sleep_fact_index = randi() % 7 
			#Advance to the next day, set as morning
			GameState.current_time_of_day = GameState.TimeOfDay.MORNING
			#Reset Player Has Done Study, Work, Hangout
			GameState.reset_player_interaction()
			#Increase Energy, Decrease Stress. Advances Time
			GameState.modify_player_stats(63,-10,0)
			update_energy_display(0)
			update_stress_display(0)
			#Pay Rent
			GameState.pay_rental(-25)
			update_calandar_display(1)
			update_money_display()
			update_room_to_time()
			# Hide the fact sprite
			$sleepAnimationPlayer/sleepFact.visible = false

func _on_gameover_from_stress_button_pressed():
	AudioManager.stop_all_music()
	get_tree().change_scene_to_file("res://scenes/sceneMainMenu.tscn")


func _on_gameover_from_rent_button_pressed():
	AudioManager.stop_all_music()
	get_tree().change_scene_to_file("res://scenes/sceneMainMenu.tscn")
