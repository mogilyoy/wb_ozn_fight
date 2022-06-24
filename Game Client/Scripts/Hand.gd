extends Spatial

export var sway_left: Vector3
export var sway_right: Vector3
export var sway_normal: Vector3

var mouseMov
var sway_threshold = 7
var sway_lerp = 1

func _input(event):
	if event is InputEventMouseMotion:
		mouseMov = event.relative.x
		
func _process(delta):
	if mouseMov != null:
		if mouseMov < sway_threshold:
			rotation = rotation.linear_interpolate(sway_left, sway_lerp*delta)
			#print(rotation, rotation.linear_interpolate(sway_left, sway_lerp*delta))
		elif mouseMov > -sway_threshold:
			rotation = rotation.linear_interpolate(sway_right, sway_lerp*delta)
		else:
			rotation = rotation.linear_interpolate(sway_normal, sway_lerp*delta)
			
			
func _ready():
	pass
