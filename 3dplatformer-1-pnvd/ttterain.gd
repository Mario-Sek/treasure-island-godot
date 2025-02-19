extends Node3D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
var MAIN_MENU = load("res://main_menu.tscn")
var END_SCREEN = load("res://end_screen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not audio_player.playing:
		audio_player.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var score_number = int(Global.final_score.split(" ")[-1])
	if score_number==75:
		get_tree().change_scene_to_packed(END_SCREEN)
	



func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)
