extends "res://addons/enemynode/enemynode_template.gd"

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var jump_timer: Timer = $jump

var state_machine : AnimationNodeStateMachinePlayback
var rng = RandomNumberGenerator.new()

func _ready():
	state_machine = animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	enemy_stats = enemy_stats.duplicate()
	hurting.connect(animplayer)
	aggro.connect(aggravated)
	jump_timer.timeout.connect(jump)

func _process(_delta):
	healthbar.set_health(enemy_stats.health)
	if is_on_floor() and state != killstate.HURT:
		state_machine.travel("idle")

func jump():
	velocity = Vector2(0,0)
	if state == killstate.AGGRO and is_on_floor():
		state_machine.travel("jump")
		velocity.y -= 500
		jump_timer.wait_time = rng.randi_range(1,3)
		jump_timer.start()

func aggravated():
	jump()

func animplayer():
	state_machine.travel("hurt")
