extends Node3D

@export var brick_scene: PackedScene
@export var rows = 10
@export var cols = 10
var offset = 2.0 * PI / abs(cols) 

func _ready():
	for row in range(rows):
		for col in range(cols):
			var brick = brick_scene.instantiate()
			var mesh_instance = brick.get_node("MeshInstance3D")
			var material = StandardMaterial3D.new()
			
			var r = randf()
			var g = randf()
			var b = randf()
			var random_color = Color(r, g, b, 1)
			material.albedo_color = random_color
			mesh_instance.material_override = material
			
			var pos = Vector3(col, row , 0)
			
			brick.position = pos
			
			add_child(brick)
			


func _process(delta):
	pass
