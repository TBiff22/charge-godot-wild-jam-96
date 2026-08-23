extends TextureButton

@export var pause_menu : Node
@onready var buttonpress: AudioStreamPlayer = $"../../buttonpress"

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_pressed() -> void:
	buttonpress.play()
	get_tree().paused = false
	pause_menu.queue_free()
