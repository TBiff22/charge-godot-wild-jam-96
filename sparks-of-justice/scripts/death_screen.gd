extends Node2D

@onready var buttonpress: AudioStreamPlayer = $buttonpress

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_retry_pressed() -> void:
	buttonpress.play()
	get_tree().paused = false
	get_tree().reload_current_scene()
