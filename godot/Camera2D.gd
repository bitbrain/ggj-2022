extends Camera2D

export(NodePath) var player_1
export(NodePath) var player_2
var p1
var p2

func _ready():
	p1 = get_node(player_1)
	p2 = get_node(player_2)
	if p1!=null&&p2!=null: 
		set_process(true)

func _process(delta):
	var newpos = (p1.global_position+p2.global_position)*0.5
	global_position = newpos
	var distance = (p1.global_position - p2.global_position).length()
	
	zoom.x = 1.0 + distance / 1500.0
	zoom.y = 1.0 + distance / 1500.0
