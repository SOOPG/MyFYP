extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_return_button_pressed():
	get_tree().change_scene_to_file("res://scenes/sceneHome.tscn")


func _on_hangout_button_pressed():
	get_tree().change_scene_to_file("res://scenes/sceneLocationHangout.tscn")


func _on_work_button_pressed():
	get_tree().change_scene_to_file("res://scenes/sceneWorkMinigame.tscn")


func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://scenes/sceneHome.tscn")
