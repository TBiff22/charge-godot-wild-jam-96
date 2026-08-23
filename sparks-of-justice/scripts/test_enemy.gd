extends "res://addons/enemynode/enemynode_template.gd"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hurtzone: CollisionShape2D = $Hurtzone/CollisionShape2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready():
	enemy_stats = enemy_stats.duplicate()
	hurting.connect(animplayer)

func animplayer():
	animation_player.play("enemy_hurt")

func _process(delta) -> void:
	healthbar.set_health(enemy_stats.health)
	if state == killstate.AGGRO:
		animation_player.play("normal")
	if sprites.flip_h == true:
		hurtzone.position.x = 25
		collision_shape_2d.position.x = 25
	elif sprites.flip_h == false:
		hurtzone.position.x = -25
		collision_shape_2d.position.x = -25
