#minigameStudyHandler
extends CanvasLayer

@onready var timer = $study/minigameTimer
@onready var timer_label = $study/timerLabel
@onready var book_area= $study/Book/BookArea
@onready var book_sprite= $study/Book
@onready var phone_sprite= $study/Phone
@onready var watch_sprite= $study/Watch
@onready var lamp_sprite= $study/Lamp
@onready var curtain_sprite= $study/Curtain
@onready var ipad_sprite= $study/Ipad

var study_progress = [
	"res://assets/scenes/minigames/study/study_progress/study-progress1.png",
	"res://assets/scenes/minigames/study/study_progress/study-progress2.png",
	"res://assets/scenes/minigames/study/study_progress/study-progress3.png",
	"res://assets/scenes/minigames/study/study_progress/study-progress4.png",
	"res://assets/scenes/minigames/study/study_progress/study-progress5.png",
	"res://assets/scenes/minigames/study/study_progress/study-progress6.png",
	"res://assets/scenes/minigames/study/study_progress/study-progress7.png",
	"res://assets/scenes/minigames/study/study_progress/study-progress8.png",
	"res://assets/scenes/minigames/study/study_progress/study-progress9.png",
	"res://assets/scenes/minigames/study/study_progress/study-progress10.png",
	"res://assets/scenes/minigames/study/study_progress/study-progress11.png",
	"res://assets/scenes/minigames/study/study_progress/study-progress12.png",
	"res://assets/scenes/minigames/study/study_progress/study-progress13.png",
	]

# For player study and book texture changes
const TOTAL_STUDY_TIME = 20.0
var NUM_PROGRESS_STEPS = 7

var time_left = 60
var win = false
var holding_down = false
var total_study_time = 0.0
var distraction_timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	book_area.input_event.connect(self._on_book_area_input_event)
	start_minigame_timer()

func _on_book_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# Set holding_down to true if the mouse button is pressed
		holding_down = event.pressed  

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer.is_stopped() && win == false:
		_on_exit_button_pressed()
		return
		
	# If the player is holding down the left click on the area
	if holding_down and total_study_time != 20:
		# Add the delta(1s) to total study time
		total_study_time += delta  
		# Update the texture based on the study time
		update_study_progress_texture(total_study_time)  
		
		#If player has hold the specified time
		if total_study_time >= TOTAL_STUDY_TIME:
			studying_complete()

	# Update the timer label text every frame with the remaining time
	time_left = int(timer.time_left)
	timer_label.text = str(time_left)

# Function to update the texture based on study time
func update_study_progress_texture(study_time):
	# Calculate the interval time
	var interval = TOTAL_STUDY_TIME / study_progress.size()  
	var index = int(study_time / interval)
	# Ensure the index does not go out of bounds
	index = clamp(index, 0, study_progress.size() - 1)  
	
	# Set and Load the appropriate texture
	var texture_path = study_progress[index]
	book_sprite.texture = load(texture_path)

# Function to call when study is complete
func studying_complete():
	win = true
	timer.stop()  # Stop the timer
	# Add any additional logic for winning here
	get_tree().change_scene_to_file("res://scenes/sceneHome.tscn")

func start_minigame_timer():
	#Starts Minigame Timer
	time_left = timer.wait_time
	timer_label.text = str(time_left)
	timer.start()

func _on_exit_button_pressed():
	# Apply penalty to player
	# Display minigame fail scene
	# Set player has done study
	GameState.playerHasDoneStudy=true
	get_tree().change_scene_to_file("res://scenes/sceneHome.tscn")
