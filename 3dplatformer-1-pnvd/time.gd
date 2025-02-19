extends Node3D

@onready var label = $Label
@onready var timer = $Timer
const END_SCREEN = preload("res://end_screen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start() 


func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left/60)
	var second = int(time_left) %60
	return [minute, second]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "%02d:%02d" % time_left_to_live()


func _on_timer_timeout() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_packed(END_SCREEN)
	
