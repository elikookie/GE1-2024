extends Marker3D

var samples:Array
var players:Array

var sequence = []

@export var path_str = "res://samples" 
@export var pad_scene:PackedScene

@export var steps = 8

func initialise_sequence(rows, cols):
	for i in range(rows):
		var row = []
		for j in range(cols):
			row.append(false)
		sequence.append(row)

func _ready():
	load_samples()
	initialise_sequence(samples.size(), steps)
	make_sequencer()
	
	for i in range(20):
		var asp = AudioStreamPlayer.new()
		add_child(asp)
		players.push_back(asp)

var asp_index = 0

func print_sequence():
	print()
	for row in range(samples.size() -1, -1, -1):
		var s = ""
		for col in range(steps):
			s += "1" if sequence[row][col] else "0" 
		print(s)
		
func play_sample(e, i):
	
	print("play sample:" + str(i))
	var p:AudioStream = samples[i]
	var asp = players[asp_index]
	asp.stream = p
	asp.play()
	asp_index = (asp_index + 1) % players.size()

func toggle(e, row, col):
	print("toggle " + str(row) + " " + str(col))
	sequence[row][col] = ! sequence[row][col]
	print_sequence()

func make_sequencer():	
	
	for col in range(steps):		
		var s = 0.1
		for row in range(samples.size()):
			var pad = pad_scene.instantiate()
			var spacer = 1.2
			var p = Vector3(s * col * spacer, s * row * spacer, 0)
			pad.position = p		
			pad.rotation = rotation
			var tm = TextMesh.new()
			tm.font_size = 1
			tm.text = str(row) + "," + str(col)
			pad.get_node("MeshInstance3D2").mesh = tm
			pad.area_entered.connect(toggle.bind(row, col))
			add_child(pad)
		
func load_samples():
	var dir = DirAccess.open(path_str)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		# From https://forum.godotengine.org/t/loading-an-ogg-or-wav-file-from-res-sfx-in-gdscript/28243/2
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			if file_name.ends_with('.wav.import'):			
				file_name = file_name.left(len(file_name) - len('.import'))
				# var asp = AudioStreamPlayer.new()
				# asp.set_stream(load(SOUND_DIR + '/' + filename))
				# add_child(asp)
				# var arr = file_name.split('/')
				# var name = arr[arr.size()-1].split('.')[0]
				# samples[name] = asp
			
				var stream = load(path_str + "/" + file_name)
				stream.resource_name = file_name
				samples.push_back(stream)
				# $AudioStreamPlayer.play()
				# break
			file_name = dir.get_next()	


func _on_timer_timeout() -> void:
	pass # Replace with function body.