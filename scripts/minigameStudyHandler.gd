#minigameStudyHandler
extends CanvasLayer

@onready var timer = $study/minigameTimer
@onready var timer_label = $study/timerLabel
@onready var book_area= $study/Book/BookArea
@onready var book_sprite= $study/Book
@onready var phone_distraction= $study/Phone/PhoneArea
@onready var watch_distraction= $study/Watch/WatchArea
@onready var lamp_distraction= $study/Lamp/LampArea
@onready var curtain_distraction= $study/Curtain/CurtainArea
@onready var ipad_distraction= $study/Ipad/IpadArea
@onready var study_fact_scene= $winAnimationPlayer/studyFacts
@onready var minigame_fail_scene= $minigameFail

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
	
var study_facts = [
	"res://assets/scenes/stress facts/study/study_facts_1.png",
	"res://assets/scenes/stress facts/study/study_facts_2.png",
	"res://assets/scenes/stress facts/study/study_facts_3.png",
	"res://assets/scenes/stress facts/study/study_facts_4.png",
	"res://assets/scenes/stress facts/study/study_facts_5.png",
	"res://assets/scenes/stress facts/study/study_facts_6.png",
	"res://assets/scenes/stress facts/study/study_facts_7.png",
]

# For player study and book texture changes
const TOTAL_STUDY_TIME = 20.0
var NUM_PROGRESS_STEPS = 7

var time_left = 60
var win = false
var holding_down = false
var total_study_time = 0.0
var distraction_timer = Timer.new()

# Track active distractions
var active_distractions = 0  

# Called when the node enters the scene tree for the first time.
func _ready():
	
	book_area.input_event.connect(self._on_book_area_input_event)
	start_minigame_timer()
	
	# Connect the distraction signals
	phone_distraction.distraction_started.connect(self._on_distraction_started)
	phone_distraction.distraction_cleared.connect(self._on_distraction_cleared)

	watch_distraction.distraction_started.connect(self._on_distraction_started)
	watch_distraction.distraction_cleared.connect(self._on_distraction_cleared)

	lamp_distraction.distraction_started.connect(self._on_distraction_started)
	lamp_distraction.distraction_cleared.connect(self._on_distraction_cleared)

	curtain_distraction.distraction_started.connect(self._on_distraction_started)
	curtain_distraction.distraction_cleared.connect(self._on_distraction_cleared)

	ipad_distraction.distraction_started.connect(self._on_distraction_started)
	ipad_distraction.distraction_cleared.connect(self._on_distraction_cleared)

func _on_book_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# Only set holding_down to true if there are no active distractions
		holding_down = event.pressed and active_distractions == 0
		

func _on_distraction_started(distraction_name):
	active_distractions += 1
	if active_distractions > 0:
		holding_down = false

func _on_distraction_cleared(distraction_name):
	active_distractions -= 1

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer.is_stopped() && win == false:
		_on_exit_button_pressed()
		return
		
	# If no distraction
	if holding_down and active_distractions == 0:
		# Add the delta(1s) to total study time
		total_study_time += delta  
		# Update the texture based on the study time
		update_study_progress_texture(total_study_time)  
			
		#If player has hold the targetted time
		if total_study_time >= TOTAL_STUDY_TIME:
			studying_complete()
	else:
		# Ensure holding down is false if there are distractions
		holding_down = false
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
	play_win_animation()

func start_minigame_timer():
	#Starts Minigame Timer
	time_left = timer.wait_time
	timer_label.text = str(time_left)
	timer.start()

func _on_exit_button_pressed():
	timer.stop()
	# Display minigame fail scene
	minigame_fail_scene.visible = true


func play_win_animation():
	if GameState.study_fact_index < study_facts.size():	
		# Load the texture for the next fact
		var fact_texture = load(study_facts[GameState.study_fact_index])
		# Set the sprite texture to the next fact
		study_fact_scene.texture = fact_texture
	# Play the animation
	$winAnimationPlayer/studyFacts.visible = true
	$winAnimationPlayer.play("minigameWin")

func _on_win_animation_player_animation_finished(anim_name):
	if anim_name == "minigameWin":
		GameState.study_fact_index+=1
		GameState.playerHasDoneStudy=true
	# Decrease Energy, Increase Stress, Increase Study
	GameState.modify_player_stats(-15,17,16)
	if GameState.current_time_of_day==GameState.TimeOfDay.AFTERNOON:
		GameState.current_time_of_day=GameState.TimeOfDay.NIGHT
	get_tree().change_scene_to_file("res://scenes/sceneHome.tscn")


func _on_minigame_fail_exit_button_pressed():
		GameState.modify_player_stats(-30,30,0)
		AudioManager.play_cancel_action_sound()
		get_tree().change_scene_to_file("res://scenes/sceneHome.tscn")
