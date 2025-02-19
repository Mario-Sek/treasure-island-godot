extends Node3D

@onready var scoreLabel: Label = $EndScreen/Label2
@onready var camera_pivot: Node3D = $EndScreen/main_menu/CameraPivot

var MAIN_MENU = load("res://main_menu.tscn")
var SCORES = load("res://scores.tscn")

func loadScore() -> void:
	var scoreboard_text = "\nTop Scores:\n"
	for score in Global.scoreboard:
		scoreboard_text += str(score) + "\n"
	
	scoreLabel.text = scoreboard_text 

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Global.load_scores()
	loadScore()


func _process(delta: float) -> void:
	pass
	

func _on_reset_pressed() -> void:
	Global.reset_scores();
	loadScore()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)
