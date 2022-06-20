extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation = $Anim
onready var sound = $Particles/BAX

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Shoot():
		animation.play("Отдача")
		



