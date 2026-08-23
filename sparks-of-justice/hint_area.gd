extends Area2D

@export var hint_text : String
@export var collisionshape: Node2D

@onready var hint_label: RichTextLabel = $"hint text"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	hint_label.text = hint_text
	hint_label.position = collisionshape.position

func _on_body_entered(body: Node2D) -> void:
	animation_player.play("appear")

func _on_body_exited(body: Node2D) -> void:
	animation_player.play("disappear")
