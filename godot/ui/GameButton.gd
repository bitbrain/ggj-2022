extends TextureButton

export(String) var text

onready var label : Label = $Label

func _ready():
	label.modulate = Color("a6859f")
	label.text = text
	
func _process(delta):
	if pressed:
		label.rect_position.y = 0
	else:
		label.rect_position.y = -1


func _on_GameButton_mouse_entered():
	label.modulate = Color("d9bdc8")


func _on_GameButton_mouse_exited():
	label.modulate = Color("a6859f")
