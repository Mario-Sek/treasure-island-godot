extends Node

var final_score: String = "0"
const SAVE_PATH = "user://scoreboard.json"
var scoreboard = [0, 0, 0, 0, 0]  

func load_scores() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var parse_result = json.parse(content)
		
		if parse_result == OK:
			scoreboard = json.data
		else:
			print("Error parsing JSON, resetting scores.")
			reset_scores()  
	else:
		save_scores()  

func add_score(new_score: int) -> void:
	scoreboard.append(new_score)  
	scoreboard.sort_custom(func(a, b): return a > b) 
	scoreboard = scoreboard.slice(0, 5)  
	save_scores()  


func save_scores() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json_string = JSON.stringify(scoreboard, "\t")
	file.store_string(json_string)
	file.close()

func reset_scores() -> void:
	scoreboard = [0, 0, 0, 0, 0]  
	save_scores()
	print("Scores have been reset.")
