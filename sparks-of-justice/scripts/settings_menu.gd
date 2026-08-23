extends Node2D
@onready var buttonpress: AudioStreamPlayer = $buttonpress

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_back_button_pressed() -> void:
	buttonpress.play()
	Globals.settings_back.emit()
	queue_free()
