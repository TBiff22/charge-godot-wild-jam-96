@tool
extends EditorPlugin


func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	add_custom_type("Room manager", "Node", preload("room_manager_template.gd"), null)

func _exit_tree() -> void:
	remove_custom_type("Room manager")
