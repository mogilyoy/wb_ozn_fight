extends Spatial


onready var animation = $AnimationPlayer 


func _on_Area_body_entered(body):
	animation.play("Open")
	pass # Replace with function body.

	pass # Replace with function body.
