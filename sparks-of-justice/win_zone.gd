extends Area2D



func _on_body_entered(body: Node2D) -> void:
	Globals.outcome = Globals.outcomes.WIN
	Globals.game_end.emit()
