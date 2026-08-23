extends Node2D

@export var buttonlist: Array[Node] = []
@onready var buttonpress: AudioStreamPlayer = $buttonpress

func _ready():
	enable_buttons()
	Globals.settings.connect(disable_buttons)
	Globals.settings_back.connect(enable_buttons)

func _on_button_pressed() -> void:
	buttonpress.play()
	get_tree().change_scene_to_file("res://scenes/level_map.tscn")

func disable_buttons():
	for button in buttonlist:
		button.disabled = true

func enable_buttons():
	for button in buttonlist:
		button.disabled = false
