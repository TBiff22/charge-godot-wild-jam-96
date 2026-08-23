@tool
extends Area2D

@export var player : Node2D
@export var enemylist : Array[Node2D] = []

var enemycont = null

func _enter_tree() -> void:
	body_entered.connect(aggro)
	body_exited.connect(calm)

func aggro(body):
	if body == player:
		for enemy in enemylist:
			if is_instance_valid(enemy):
				enemy.aggro.emit()

func calm(body):
	for enemy in enemylist:
		if is_instance_valid(enemy):
			enemy.calm.emit()
	
