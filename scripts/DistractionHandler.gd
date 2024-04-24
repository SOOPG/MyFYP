#DistractionHandler
extends Area2D

@export var idle_texture: Texture
@export var distraction_texture: Texture
# Minimum Time for Distraction to re-appear
@export var min_distraction_interval: float = 3.0
# Maximum Time for Distraction to re-appear
@export var max_distraction_interval: float = 5.0
# Minimum Cool Down
@export var min_cooldown_time: float = 3.0
# Maximum Cool Down
@export var max_cooldown_time: float = 5.0

var distraction_timer = Timer.new()
var cooldown_timer = Timer.new()

@onready var sprite = get_parent() as Sprite2D

signal distraction_started(name)
signal distraction_cleared(name)

# Global script or singleton to manage active distractions
var active_distractions = 0
# Adjust based on desired difficulty
var required_active_distractions = 3  

# Called when the node enters the scene tree for the first time.
func _ready():
	#Connect  Signasl
	self.connect("input_event", Callable(self, "_on_Area2D_input_event"))
	
	# Set the initial texture to idle
	sprite.texture = idle_texture

	# Set up and add the distraction timer as a child of this node
	distraction_timer.set_wait_time(randf_range(min_distraction_interval, max_distraction_interval))
	# Timer will stop after triggering once
	distraction_timer.set_one_shot(true)  
	add_child(distraction_timer)
	distraction_timer.timeout.connect(self._on_distraction_timer_timeout)

	# Set up and add the cooldown timer as a child of this node
	cooldown_timer.set_wait_time(randf_range(min_cooldown_time, max_cooldown_time))
	# Timer will stop after triggering once
	cooldown_timer.set_one_shot(true)
	add_child(cooldown_timer)
	cooldown_timer.timeout.connect(self._on_cooldown_timer_timeout)
	
	maybe_start_distraction()

func maybe_start_distraction():
	# Determine the chance to start based on the number of active distractions
	var chance_to_start = 0.5  # default chance
	if active_distractions < required_active_distractions:
		chance_to_start = 1.0  # increase chance if fewer than required distractions are active

	# Randomly decide if this distraction should start now based on the chance
	if randf() < chance_to_start:
		distraction_timer.start()
		active_distractions += 1  # increase the count of active distractions

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		clear_distraction()  # Player clicked the distraction, clear it

func _on_distraction_timer_timeout():
	# Time to trigger a distraction
	sprite.texture = distraction_texture
	# Signal the parent or main handler if necessary
	emit_signal("distraction_started", self.name)

func _on_cooldown_timer_timeout():
	# Distraction cooldown has ended, it can be triggered again
	distraction_timer.start(randf_range(min_distraction_interval, max_distraction_interval))

func clear_distraction():
	sprite.texture = idle_texture
	cooldown_timer.start(randf_range(min_cooldown_time, max_cooldown_time))
	emit_signal("distraction_cleared", self.name)
	active_distractions -= 1
