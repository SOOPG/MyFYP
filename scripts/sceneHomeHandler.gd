extends CanvasLayer

@onready var room_sprite = $room
@onready var bed_button = $BedButton
@onready var bed_hover_icon = $BedButton/bed_hover
@onready var study_button = $StudyButton
@onready var study_hover_icon = $StudyButton/study_hover
@onready var door_button = $DoorButton
@onready var door_hover_icon = $DoorButton/door_hover

#Time of the Day
enum TimeOfDay {
	MORNING,
	AFTERNOON,
	NIGHT
}

var current_time_of_day = TimeOfDay.MORNING

#To Update the Room based on the time of the day
func update_room_sprite():
	match current_time_of_day:
		TimeOfDay.MORNING:
			room_sprite.texture = preload("res://assets/scenes/apartment/room_base_time_1.png")
		TimeOfDay.AFTERNOON:
			room_sprite.texture = preload("res://assets/scenes/apartment/room_base_time_2.png")
		TimeOfDay.NIGHT:
			room_sprite.texture = preload("res://assets/scenes/apartment/room_base_time_3.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hover sprites are not visible at the start
	bed_hover_icon.visible = false
	study_hover_icon.visible = false
	door_hover_icon.visible = false

	# Connect the mouse_entered and mouse_exited signals
	bed_button.mouse_entered.connect(self._on_bed_mouse_entered)
	bed_button.mouse_exited.connect(self._on_bed_mouse_exited)
	
	study_button.mouse_entered.connect(self._on_study_mouse_entered)
	study_button.mouse_exited.connect(self._on_study_mouse_exited)

	door_button.mouse_entered.connect(self._on_door_mouse_entered)
	door_button.mouse_exited.connect(self._on_door_mouse_exited)


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

func _on_door_button_pressed():
	if current_time_of_day == TimeOfDay.MORNING:
		#If morning, attend class when clicked on door
		get_tree().change_scene_to_file("res://scenes/sceneAttendClass.tscn")
	else:
		#Go to the selector menu
		get_tree().change_scene_to_file("res://scenes/sceneMainMenu.tscn")
