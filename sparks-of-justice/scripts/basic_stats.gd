extends Resource
class_name basic_stats

@export var type : String = "null"
@export var attack : int = 2
@export var defense : int = 1
@export var health : int = 20
@export var gravity : float = 0.0
@export var speed : float = 300.0

func take_damage(amount : int) -> void:
	health -= amount
