extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play(125)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var menu_bgm_time = get_playback_position()
	if menu_bgm_time >= 190:
		play(125)
