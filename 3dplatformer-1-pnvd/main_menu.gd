extends Node3D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer  # Reference the AudioStreamPlayer

var rotation_speed = 6
const SCORES = preload("res://scores.tscn")
const TERRAIN = preload("res://ttterain.tscn")

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	audio_player.play()  # Play sound when the scene loads

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_scores_button_pressed() -> void:
	get_tree().change_scene_to_packed(SCORES)
	
func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_packed(TERRAIN)
