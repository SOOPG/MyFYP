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
	if GameState.energy < 0:
		GameState.energy = 0
	if	GameState.energy > 100:
		GameState.energy = 100
	# Determine the texture to load based on the energy range
	if GameState.energy == 0:
		energy_ui.texture = load("res://assets/sprites/ui/status_bars/energy/energy_level_0.png")
	elif GameState.energy > 0 and GameState.energy <= 25:
		energy_ui.texture = load("res://assets/sprites/ui/status_bars/energy/energy_level_25.png")
	elif GameState.energy > 25 and GameState.energy <= 50:
		energy_ui.texture = load("res://assets/sprites/ui/status_bars/energy/energy_level_50.png")
	elif GameState.energy > 50 and GameState.energy <= 75:
		energy_ui.texture = load("res://assets/sprites/ui/status_bars/energy/energy_level_75.png")
	elif GameState.energy > 75:
		energy_ui.texture = load("res://assets/sprites/ui/status_bars/energy/energy_level_100.png")

#To Update the Stress
func update_stress_display(modifier :int):
	GameState.stress = GameState.stress + modifier
	if GameState.stress < 0:
		GameState.stress = 0
	if	GameState.stress > 100:
		GameState.stress = 100
	# Determine the texture to load based on the energy range
	if GameState.stress == 0:
		stress_ui.texture = load("res://assets/sprites/ui/status_bars/stress/stress_level_0.png")
	elif GameState.stress > 0 and GameState.stress <= 25:
		stress_ui.texture = load("res://assets/sprites/ui/status_bars/stress/stress_level_25.png")
	elif GameState.stress > 25 and GameState.stress <= 50:
		stress_ui.texture = load("res://assets/sprites/ui/status_bars/stress/stress_level_50.png")
	elif GameState.stress > 50 and GameState.stress <= 75:
		stress_ui.texture = load("res://assets/sprites/ui/status_bars/stress/stress_level_75.png")
	elif GameState.stress > 75:
		stress_ui.texture = load("res://assets/sprites/ui/status_bars/stress/stress_level_100.png")

#To Update the Study
func update_study_display(modifier :int):
	GameState.study = GameState.study + modifier
	if GameState.study < 0:
		GameState.study = 0
	if	GameState.study > 100:
		GameState.study = 100
	# Determine the texture to load based on the energy range
	if GameState.study == 0:
		study_ui.texture = load("res://assets/sprites/ui/status_bars/study/study_level_0.png")
	elif GameState.study > 0 and GameState.study <= 25:
		study_ui.texture = load("res://assets/sprites/ui/status_bars/study/study_level_25.png")
	elif GameState.study > 25 and GameState.study <= 50:
		study_ui.texture = load("res://assets/sprites/ui/status_bars/study/study_level_50.png")
	elif GameState.study > 50 and GameState.study <= 75:
		study_ui.texture = load("res://assets/sprites/ui/status_bars/study/study_level_75.png")
	elif GameState.study > 75:
		study_ui.texture = load("res://assets/sprites/ui/status_bars/study/study_level_100.png")

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

# Called when the node enters the scene tree for the first time.
func _ready():
	
	update_room_to_time()
	update_energy_display(0)
	update_stress_display(0)
	update_calandar_display(0)

	# Connect the mouse_entered and mouse_exited signals
	bed_button.mouse_entered.connect(self._on_bed_mouse_entered)
	bed_button.mouse_exited.connect(self._on_bed_mouse_exited)
	study_button.mouse_entered.connect(self._on_study_mouse_entered)
	study_button.mouse_exited.connect(self._on_study_mouse_exited)
	door_button.mouse_entered.connect(self._on_door_mouse_entered)
	door_button.mouse_exited.connect(self._on_door_mouse_exited)

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
		#If morning, notify player that they cant sleep now
		dispMsgToClass($Message, "I can't sleep now...", 3.0)
	else:
		#Fade in Animation
		#Advance to the next day, set as morning
		GameState.current_time_of_day == GameState.TimeOfDay.MORNING
		update_room_to_time()
		#Increase Energy, Decrease Stress. Advances Time
		update_energy_display(50)
		update_stress_display(-10)
		update_calandar_display(1)

#Player interact with study table
func _on_study_button_pressed():
	if GameState.current_time_of_day == GameState.TimeOfDay.MORNING:
		#If morning, notify player that they have to attend class
		dispMsgToClass($Message, "I need to attend class first....", 3.0)
	else:
		#Go to the study scene
		get_tree().change_scene_to_file("res://scenes/sceneStudyMinigame.tscn")

#Player interact with door
func _on_door_button_pressed():
	if GameState.current_time_of_day == GameState.TimeOfDay.MORNING:
		# If morning, attend class when clicked on door
		$attendClassAnimationPlayer.play("attendClass")
		$attendClassAnimationPlayer/sceneClassroom.visible = true
		# Increase Stress, Study Decrease Energy
		update_energy_display(-25)
		update_stress_display(15)
		update_study_display(3)
	else:
		#Allow Player to go to the selector menu
		get_tree().change_scene_to_file("res://scenes/sceneLocationSelectorMenu.tscn")

func _on_attendClassAnimationFinished(anim_name):
	if anim_name == "attendClass":
		# Hide the classroom sprite
		$attendClassAnimationPlayer/sceneClassroom.visible = false
		# Change the time to Afternoon
		GameState.current_time_of_day = GameState.TimeOfDay.AFTERNOON
		update_room_to_time()
