extends TextureButton

export(String) var text

onready var label : Label = $Label
onready var hover_sound = $HoverSound
onready var click_sound = $ClickSound

func _ready():
	label.modulate = Color("a6859f")
	label.text = text
	
func _process(delta):
	if pressed:
		label.rect_position.y = 0
	else:
		label.rect_position.y = -1


func _on_GameButton_mouse_entered():
	hover_sound.play()
	label.modulate = Color("d9bdc8")


func _on_GameButton_mouse_exited():
	label.modulate = Color("a6859f")

func _on_GameButton_pressed():
	click_sound.play()
