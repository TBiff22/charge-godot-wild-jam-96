extends "res://addons/room manager/room_manager_template.gd"

@onready var charge_counter: RichTextLabel = $"../charge counter"

func _process(delta):
	charge_counter.text = str(Globals.player_stats["charge"])
