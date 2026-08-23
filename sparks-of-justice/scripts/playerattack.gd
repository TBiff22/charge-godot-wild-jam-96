extends Area2D
@onready var attack_anims: AnimationPlayer = $attack_anims

var charged : bool = false

func _ready():
	if charged == true:
		attack_anims.play("charged atk")
	elif charged == false:
		attack_anims.play("normal atk")

func _on_body_entered(body: Node2D) -> void:
	body.hurting.emit()
