extends CanvasLayer

@onready var bed_control = $BedControl
@onready var bed_hover_icon = $BedControl/bed_hover
@onready var study_control = $StudyControl
@onready var study_hover_icon = $StudyControl/study_hover
@onready var door_control = $DoorControl
@onready var door_hover_icon = $DoorControl/door_hover

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hover sprites are not visible at the start
	bed_hover_icon.visible = false
	study_hover_icon.visible = false
	door_hover_icon.visible = false

	# Connect the mouse_entered and mouse_exited signals
	bed_control.mouse_entered.connect(self._on_bed_mouse_entered)
	bed_control.mouse_exited.connect(self._on_bed_mouse_exited)
	
	study_control.mouse_entered.connect(self._on_study_mouse_entered)
	study_control.mouse_exited.connect(self._on_study_mouse_exited)

	door_control.mouse_entered.connect(self._on_door_mouse_entered)
	door_control.mouse_exited.connect(self._on_door_mouse_exited)


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
