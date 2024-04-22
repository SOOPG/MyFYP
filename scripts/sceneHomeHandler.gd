extends CanvasLayer

@onready var room_sprite = $room
@onready var bed_button = $BedButton
@onready var bed_hover_icon = $BedButton/bed_hover
@onready var study_button = $StudyButton
@onready var study_hover_icon = $StudyButton/study_hover
@onready var door_button = $DoorButton
@onready var door_hover_icon = $DoorButton/door_hover

#To Update the Room based on the time of the day
func update_room_to_time():
	match GameState.current_time_of_day:
		GameState.TimeOfDay.MORNING:
			room_sprite.texture = preload("res://assets/scenes/apartment/room_base_time_1.png")
		GameState.TimeOfDay.AFTERNOON:
			room_sprite.texture = preload("res://assets/scenes/apartment/room_base_time_2.png")
		GameState.TimeOfDay.NIGHT:
			room_sprite.texture = preload("res://assets/scenes/apartment/room_base_time_3.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	update_room_to_time()
	
	# Connect the mouse_entered and mouse_exited signals
	bed_button.mouse_entered.connect(self._on_bed_mouse_entered)
	bed_button.mouse_exited.connect(self._on_bed_mouse_exited)
	
	study_button.mouse_entered.connect(self._on_study_mouse_entered)
	study_button.mouse_exited.connect(self._on_study_mouse_exited)

	door_button.mouse_entered.connect(self._on_door_mouse_entered)
	door_button.mouse_exited.connect(self._on_door_mouse_exited)

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


#User pressed on study table
func _on_study_button_pressed():
	if GameState.current_time_of_day == GameState.TimeOfDay.MORNING:
		#If morning, notify player that they have to attend class
		$Msg_goto_class.visible = true
	else:
		#Go to the selector menu
		get_tree().change_scene_to_file("res://scenes/sceneStudyMinigame.tscn")

#User pressed on door
func _on_door_button_pressed():
	if GameState.current_time_of_day == GameState.TimeOfDay.MORNING:
		#If morning, attend class when clicked on door
		$attendClassAnimationPlayer.play("attendClass")
		$attendClassAnimationPlayer/sceneClassroom.visible = true
	else:
		#Go to the selector menu
		get_tree().change_scene_to_file("res://scenes/sceneLocationSelectorMenu.tscn")

func _on_attendClassAnimationFinished(anim_name):
	if anim_name == "attendClass":
		# Hide the classroom sprite
		$attendClassAnimationPlayer/sceneClassroom.visible = false
		# Change the time to Afternoon
		GameState.current_time_of_day = GameState.TimeOfDay.AFTERNOON
		update_room_to_time()
