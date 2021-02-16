extends Label

### Show FPS on Screen ###

func _process(_delta):
	get_node(".").text = "\nFPS: " + str(Performance.get_monitor(Performance.TIME_FPS))
	
