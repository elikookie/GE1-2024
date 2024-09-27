extends MeshInstance3D

@export var speed:float = -2
@export var rotSpeed = 180.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position.z += speed * delta
	
	var f = Input.get_axis("up","down")
	var d = Input.get_axis("left","right")
	translate(Vector3(0,0, f * delta * speed))
	
	rotate_y(rotSpeed * d * delta)
	##rotate - 3 params - rotates x, y x in radiens
	#rotate_x(deg_to_rad(rotSpeed) * delta)
	#rotate_y(deg_to_rad(rotSpeed) * delta)
	#rotate_z(deg_to_rad(rotSpeed) * delta)
