extends Area2D

func _ready():
	body_entered.connect(respawn_set)

func respawn_set(body):
	Globals.nearest_respawn = position
