extends Node2D

# WARNING: BEFORE USING IT MAKE FILE AT "user://save.json" 
const save_file = "user://save.json"

var player = {
	"health": 0,
	"position": {
		"x": 0,
		"y": 0
	},
	"interacted": [
		
	]
}
func _ready():
	Signalbus.connect("loading_world",self,"on_loading")

func save_file():
	print(player)
	var file = File.new()
	file.open(save_file, File.WRITE)
	file.store_string(to_json(player))
	file.close()

func load_file():
	var file = File.new()
	if file.file_exists(save_file):
		file.open(save_file, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			player = data
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")

func on_loading():
	player["interacted"] = []
