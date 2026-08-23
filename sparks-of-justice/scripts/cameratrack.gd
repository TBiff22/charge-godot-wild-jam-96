extends Marker2D
@onready var player: CharacterBody2D = $"../.."


func _process(delta: float) -> void:
	position = player.position + Vector2(0,-100)
