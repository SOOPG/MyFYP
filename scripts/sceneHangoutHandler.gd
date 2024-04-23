extends CanvasLayer

@onready var hangout_fact_scene = $hangoutAnimationPlayer/hangoutFact

var friends_facts = [
	"res://assets/scenes/stress facts/hangout/friends_fact_1.png",
	"res://assets/scenes/stress facts/hangout/friends_fact_2.png",
	"res://assets/scenes/stress facts/hangout/friends_fact_3.png",
	"res://assets/scenes/stress facts/hangout/friends_fact_4.png",
	"res://assets/scenes/stress facts/hangout/friends_fact_5.png",
	"res://assets/scenes/stress facts/hangout/friends_fact_6.png",
	"res://assets/scenes/stress facts/hangout/friends_fact_7.png",
	]
	
# Member variable to keep track of the fact index

# Called when the node enters the scene tree for the first time.
func _ready():
	hangoutAnimationPlayer()

# Hangout
func hangoutAnimationPlayer():
	if GameState.hangout_fact_index < friends_facts.size():	
		# Load the texture for the next fact
		var fact_texture = load(friends_facts[GameState.hangout_fact_index])
		# Set the sprite texture to the next fact
		hangout_fact_scene.texture = fact_texture
		
	#Play Hangout Animation
	$hangoutAnimationPlayer/hangout.visible = true
	$hangoutAnimationPlayer/hangoutFact.visible = true
	$hangoutAnimationPlayer.play("hangout")

func _on_hangout_animation_player_animation_finished(anim_name):
	if anim_name == "hangout":
		GameState.hangout_fact_index+=1
		# Modify : (Energy, Stress, Study)
		GameState.modify_player_stats(-33,-50,0)
		GameState.playerHasDoneHangout=true
		$hangoutAnimationPlayer/hangout.visible = false
		$hangoutAnimationPlayer/hangoutFact.visible = false
		get_tree().change_scene_to_file("res://scenes/sceneHome.tscn")
