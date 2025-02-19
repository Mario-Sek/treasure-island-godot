extends Node3D

@onready var label: Label = $"Label"
@onready var scoreLabel: Label = $"Label2"
@onready var camera_pivot: Node3D = $CameraPivot
@onready var won_label: Label = $WonLabel


var MAIN_MENU = load("res://main_menu.tscn")
var TERRRAIN = load("res://ttterain.tscn")

var rotation_speed = 3

func _ready() -> void:

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Global.load_scores()
	
	var score_number = 0
	score_number = int(Global.final_score.split(" ")[-1])

	if score_number==75:
		won_label.text = "You Won!"
		

	Global.add_score(score_number)

	var scoreboard_text = "\nTop Scores:\n"
	for score in Global.scoreboard:
		scoreboard_text += str(score) + "\n"
	
	label.text = Global.final_score
	scoreLabel.text = scoreboard_text 
	

func _process(delta: float) -> void:
	pass
	



func _on_play_bttn_pressed() -> void:
	get_tree().change_scene_to_packed(TERRRAIN)


func _on_menu_bttn_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)
