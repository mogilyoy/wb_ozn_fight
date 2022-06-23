extends Spatial

var bot = preload("res://Scens/BadGuy.tscn")


func spawn():
		var mob = bot.instance()
		self.add_child(mob)

func _on_Timer_timeout():
	spawn()
