extends Node2D

@export var buttonlist : Array[Node] = []

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	enable_buttons()
	Globals.settings.connect(disable_buttons)
	Globals.settings_back.connect(enable_buttons)

func disable_buttons():
	for button in buttonlist:
		button.disabled = true

func enable_buttons():
	for button in buttonlist:
		button.disabled = false
