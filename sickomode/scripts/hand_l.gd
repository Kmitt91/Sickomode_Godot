extends BoneAttachment

onready var magic = preload("res://particle.tscn")
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("2"):
		var particle = magic.instance()
		add_child(particle)
		

