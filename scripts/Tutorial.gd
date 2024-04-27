extends CanvasLayer

var tutorial_pages = [
	preload("res://assets/scenes/menus/tutorial_1.png"),
	preload("res://assets/scenes/menus/tutorial_2.png"),
	preload("res://assets/scenes/menus/tutorial_3.png"),
	preload("res://assets/scenes/menus/tutorial_4.png")
]

var current_page = 0

# Called to display the first page of tutorial.
func _ready():
	preload("res://assets/scenes/menus/tutorial_1.png")

func _on_next_pressed():
	AudioManager.play_confirm_action_sound()
	current_page += 1
	# Check where the tutorial page currently is at
	if current_page >= tutorial_pages.size():
		# If at last page of tutorial, return to main menu
		get_tree().change_scene_to_file("res://scenes/sceneMainMenu.tscn")
	else:
		# Otherwise go to the next tutorial page
		$tutorial_page.texture = tutorial_pages[current_page]
