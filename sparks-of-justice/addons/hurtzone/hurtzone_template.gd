@tool
extends Area2D

@export var damage: int = 2

func _enter_tree():
	body_entered.connect(hurt_player)

func hurt_player(body):
	Globals.damage_amount = damage
	Globals.player_hurt.emit()
