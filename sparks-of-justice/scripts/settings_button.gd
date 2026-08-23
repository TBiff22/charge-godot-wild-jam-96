extends TextureButton

@export var menu : Node2D
@export var positioning : Node2D
@onready var buttonpress: AudioStreamPlayer = $buttonpress

var settings = preload("res://scenes/settings_menu.tscn")

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_pressed() -> void:
	buttonpress.play()
	var setting_menu = settings.instantiate()
	setting_menu.position = positioning.position
	menu.add_child(setting_menu)
	Globals.settings.emit()
