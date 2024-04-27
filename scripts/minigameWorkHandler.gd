#sceneWorkMinigame
extends CanvasLayer

@onready var timer = $work/minigameTimer
@onready var timer_label = $work/timerLabel
@onready var grocer_order = $work/grocerOrder
@onready var work_fact_scene = $winAnimationPlayer/workFacts
@onready var minigame_fail_scene = $minigameFail

enum GrocerItems {
	item1, # corresponds to grocer_1.png
	item2, # corresponds to grocer_2.png
	item3, # corresponds to grocer_3.png
	item4, # corresponds to grocer_4.png
	item5, # corresponds to grocer_5.png
	item6, # corresponds to grocer_6.png
	item7, # corresponds to grocer_7.png
	item8, # corresponds to grocer_8.png
	item9 # corresponds to grocer_9.png
}

var grocer_enum_values = [
	GrocerItems.item1, 
	GrocerItems.item2, 
	GrocerItems.item3, 
	GrocerItems.item4, 
	GrocerItems.item5,
	GrocerItems.item6, 
	GrocerItems.item7, 
	GrocerItems.item8, 
	GrocerItems.item9
]

var grocer_textures={
	GrocerItems.item1:preload("res://assets/scenes/minigames/work/grocery/grocer_1.png"),
	GrocerItems.item2:preload("res://assets/scenes/minigames/work/grocery/grocer_2.png"),
	GrocerItems.item3:preload("res://assets/scenes/minigames/work/grocery/grocer_3.png"),
	GrocerItems.item4:preload("res://assets/scenes/minigames/work/grocery/grocer_4.png"),
	GrocerItems.item5:preload("res://assets/scenes/minigames/work/grocery/grocer_5.png"),
	GrocerItems.item6:preload("res://assets/scenes/minigames/work/grocery/grocer_6.png"),
	GrocerItems.item7:preload("res://assets/scenes/minigames/work/grocery/grocer_7.png"),
	GrocerItems.item8:preload("res://assets/scenes/minigames/work/grocery/grocer_8.png"),
	GrocerItems.item9:preload("res://assets/scenes/minigames/work/grocery/grocer_9.png")
}

var work_facts = [
	"res://assets/scenes/stress facts/work/work_facts_1.png",
	"res://assets/scenes/stress facts/work/work_facts_2.png",
	"res://assets/scenes/stress facts/work/work_facts_3.png",
	"res://assets/scenes/stress facts/work/work_facts_4.png",
	"res://assets/scenes/stress facts/work/work_facts_5.png",
	"res://assets/scenes/stress facts/work/work_facts_6.png",
	"res://assets/scenes/stress facts/work/work_facts_7.png",
	]

var time_left = 35
var correctOrder = 0

# Stop timer based on condition, 
#if player win: stop timer, then go to win animation
#if player lose by timer: stop timer the go to lose animation
var win = false

# Initialize with an invalid index
var last_item_index = -1 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# connect buttons to texture
	connect_buttons_to_textures()
	# Start Timer
	start_minigame_timer()
	# Select the new grocer order
	select_new_grocer_order()
	
#Connect Buttons to the Textures
func connect_buttons_to_textures():
	connect_button($work/grocer1Button, GrocerItems.item1)
	connect_button($work/grocer2Button, GrocerItems.item2)
	connect_button($work/grocer3Button, GrocerItems.item3)
	connect_button($work/grocer4Button, GrocerItems.item4)
	connect_button($work/grocer5Button, GrocerItems.item5)
	connect_button($work/grocer6Button, GrocerItems.item6)
	connect_button($work/grocer7Button, GrocerItems.item7)
	connect_button($work/grocer8Button, GrocerItems.item8)
	connect_button($work/grocer9Button, GrocerItems.item9)
	
func connect_button(button, item_index):
	# Create a callable from the method
	var method_callable = Callable(self, "_on_grocer_button_pressed")
	# Bind the item_index to the callable
	method_callable = method_callable.bind(item_index)
	# Connect the signal
	button.pressed.connect(method_callable)

# When grocer is pressed
func _on_grocer_button_pressed(button_index):

	# Current order texture
	var current_order_texture = grocer_order.texture
	# Assign the correct button based on the texture
	var selected_item_texture = grocer_textures[button_index]

	if current_order_texture == selected_item_texture:
		# Play Correct Sound
		AudioManager.play_correct_sound()
		correctOrder+=1
		print("Correct item selected!")
		#Let players do x times
		if correctOrder<7:
			# Pick a new random item for grocer_order
			select_new_grocer_order()  
		else:
			win = true
			timer.stop()
			play_win_animation()
	elif current_order_texture != selected_item_texture:
		# Play Wrong Sound
		AudioManager.play_wrong_sound()

func play_win_animation():
	if GameState.work_fact_index < work_facts.size():	
		# Load the texture for the next fact
		var fact_texture = load(work_facts[GameState.work_fact_index])
		# Set the sprite texture to the next fact
		work_fact_scene.texture = fact_texture
		
	#Play the animation
	$winAnimationPlayer/workFacts.visible = true
	$winAnimationPlayer.play("minigameWin")

func select_new_grocer_order():
	var random_item_index = last_item_index
	# Ensure a new item is picked different from the last one
	while random_item_index == last_item_index:
		random_item_index = grocer_enum_values[randi() % grocer_enum_values.size()]
	# Update the last item index
	last_item_index = random_item_index  
	# Set the texture for what the grocer the player needs to select
	grocer_order.texture = grocer_textures[grocer_enum_values[random_item_index]]

func start_minigame_timer():
	#Starts Minigame Timer
	time_left = timer.wait_time
	timer_label.text = str(time_left)
	timer.start()

func _process(delta):
	if timer.is_stopped() && win == false:
		_on_exit_button_pressed()
		return
	# Update the timer label text every frame with the remaining time
	time_left = int(timer.time_left)
	timer_label.text = str(time_left)

#If player runs out of time or exit, apply penalty to energy and stress while exit scene
func _on_exit_button_pressed():
	timer.stop()
	# Display minigame fail scene
	minigame_fail_scene.visible = true

func _on_win_animation_player_animation_finished(anim_name):
	if anim_name == "minigameWin":
		GameState.work_fact_index+=1
		# Set player has done job
		GameState.playerHasDoneJob=true
		# Player Energy Reduced while Stress Increased
		GameState.modify_player_stats(-31,17,0)
		# Player Earns Money
		GameState.modify_player_money(56)
		GameState.current_time_of_day=GameState.TimeOfDay.NIGHT
		# Win minigame, show the work facts
		get_tree().change_scene_to_file("res://scenes/sceneHome.tscn")


func _on_minigame_exit_button_pressed():
	# Apply penalty to player
	AudioManager.play_cancel_action_sound()
	GameState.modify_player_stats(-20,35,0)
	get_tree().change_scene_to_file("res://scenes/sceneHome.tscn")
