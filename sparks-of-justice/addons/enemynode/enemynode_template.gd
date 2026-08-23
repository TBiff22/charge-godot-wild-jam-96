@tool
extends CharacterBody2D

@export var enemy_stats: basic_stats
@export var knockback: int = 200
@export var speedmult: float = 1.0
@export var sprites: Node2D
@export var healthbar: Node

var ouch = false

signal enemy_down
signal hurting
signal aggro
signal calm

enum killstate {AGGRO, HURT, IDLE, DEAD}
var state = killstate.IDLE

func _enter_tree():
	aggro.connect(playerlock)
	calm.connect(calming)
	hurting.connect(damaged)
	healthbar.init_health(enemy_stats.health)

func calming():
	state = killstate.IDLE

func damaged():
	if state != killstate.HURT:
		enemy_stats.take_damage(Globals.player_stats["atk"])
		state = killstate.HURT
	var dir = position.direction_to(Globals.player_pos)
	velocity -= dir * speedmult * knockback
	if enemy_stats.health <= 0:
		dead()

func _physics_process(delta:float)->void:
	animation_flip()
	if state == killstate.AGGRO:
		velocity += get_gravity() * delta * enemy_stats.gravity
		if enemy_stats.type == "crawling enemy":
			slowcrawl(delta)
		elif enemy_stats.type == "jumping enemy":
			if not is_on_floor():
				slowcrawl(delta)
	elif state == killstate.HURT:
		velocity *= 0.9
	elif state == killstate.IDLE:
		velocity += get_gravity() * delta * enemy_stats.gravity
	move_and_slide()

func nothurt():
	print("recovered")
	velocity = Vector2(0,0)
	playerlock()

func playerlock():
	state = killstate.AGGRO

func dead():
	enemy_down.emit()
	Globals.enemydown.emit()
	state = killstate.DEAD
	queue_free()

#different movement scripts down here
func slowcrawl(delta):
	position.x = move_toward(position.x, Globals.player_pos.x, speedmult)

func animation_flip():
	var xdir = Vector2(Globals.player_pos - position).x
	if state!= killstate.HURT:
		if xdir < 0:
			sprites.flip_h = false
		elif xdir > 0:
			sprites.flip_h = true
	
