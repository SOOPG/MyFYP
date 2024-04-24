#minigameStudyHandler
extends CanvasLayer

@onready var timer = $study/minigameTimer
@onready var timer_label = $study/timerLabel
@onready var book_area=$study/Book/BookArea

var time_left = 60
var win = false
var holding_down = false
var studying_progress = 0.0
var progress_per_second = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	start_minigame_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer.is_stopped() && win == false:
		_on_exit_button_pressed()
		return
	# Update the timer label text every frame with the remaining time
	time_left = int(timer.time_left)
	timer_label.text = str(time_left)

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
