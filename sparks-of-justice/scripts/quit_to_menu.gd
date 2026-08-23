extends TextureButton
@onready var buttonpress: AudioStreamPlayer = $buttonpress

func _on_pressed() -> void:
	buttonpress.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
