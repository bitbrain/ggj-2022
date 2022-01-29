class_name Overlay
extends ColorRect

signal on_complete_fade_in
signal on_complete_fade_out

export(float) var fade_in_duration = 1.0
export(float) var fade_out_duration = 1.0
export(bool) var auto_fade_in = false 
export(float) var minimum_opacity = 1.0

onready var tween = $Tween

var fading_in = true

func _ready():
	modulate.a = minimum_opacity
	if auto_fade_in:
		fade_in()

func fade_in():
	tween.stop_all()
	fading_in = true
	tween.interpolate_property(self, "modulate:a", modulate.a, 0, fade_in_duration, Tween.TRANS_CUBIC)
	tween.start()

func fade_out():
	tween.stop_all()
	fading_in = false
	tween.interpolate_property(self, "modulate:a", modulate.a, minimum_opacity, fade_out_duration, Tween.TRANS_CUBIC)
	tween.start()

func _on_Tween_tween_completed(object,_key):
	if fading_in:
		emit_signal("on_complete_fade_in")
	else:
		emit_signal("on_complete_fade_out")
