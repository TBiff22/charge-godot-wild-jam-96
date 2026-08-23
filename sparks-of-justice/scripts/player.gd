extends CharacterBody2D
@export var room_manager : Node

@onready var charge_animation: AnimatedSprite2D = $"charge animation"
@onready var death_buffer_timer: Timer = $"death buffer timer"
@onready var charge_timeout: Timer = $"charge timeout"
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var attack_cooldown: Timer = $"attack cooldown"
@onready var glow_effect_player: AnimationPlayer = $"glow effect player"
@onready var charge_sound: AudioStreamPlayer = $sfx/charge
@onready var uncharge: AudioStreamPlayer = $sfx/uncharge

var state_machine : AnimationNodeStateMachinePlayback
var attackpreload = preload("res://scenes/playerattack.tscn")
var facing: Vector2 = Vector2.RIGHT
enum movemode {ATK, JUMP, NORMAL, HURT, END}


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var globalhealth = Globals.player_stats["health"]
var globalcharge = Globals.player_stats["charge"]

var charged : bool = false
var attacktrack: bool = false
var currentmode = movemode.NORMAL

var speedmult = 1
var health: int
var charge: int

const SPEED = 500.0
const JUMP_VELOCITY = -800.0

func _ready():
	charge_animation.visible = false
	state_machine = animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	Globals.player_hurt.connect(hurt)
	Globals.game_end.connect(endgame)

func _process(delta: float) -> void:
	update_animation()
	health = clampi(globalhealth, 0,20)
	charge = clampi(globalcharge,0,10)
	if globalhealth > 20:
		globalhealth = 20
	if globalcharge > 20:
		globalcharge = 20
	if charged == true:
		Globals.player_stats["atk"] = 4
	else:
		Globals.player_stats["atk"] = 2
	Globals.player_pos = position
	if Input.is_action_just_pressed("attack") and attacktrack == false:
		attacking()
	if health <= 0:
		if Globals.outcome == Globals.outcomes.LOSE:
			pass
		else:
			Globals.outcome = Globals.outcomes.LOSE
			Globals.game_end.emit()	
		state_machine.travel("death")
	if Input.is_action_just_pressed("pause"):
		room_manager.pause_game()
	

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta * 2
	if currentmode == movemode.NORMAL:
		normal_movement()
	elif currentmode == movemode.HURT:
		velocity.x *= 0.9
		move_and_slide()
	elif currentmode == movemode.END:
		velocity = Vector2(0,0)
		position += Vector2(0,0)

func normal_movement():
	var direction := Input.get_axis("left", "right")
	if Input.is_action_just_pressed("charge") and charged != true and globalcharge > 0:
		charged = true
		globalcharge -= 1
		charge_visuals()
		charge_sound.play()
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		else:
			if charged == true:
				velocity.y = JUMP_VELOCITY
				glow_effect_player.play("glow effect")
				uncharge.play()
				charged = false
				charge_animation.visible = false
	if direction:
		facing.x = direction
		velocity.x = direction * SPEED
	else:
		facing.y = 0
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func hurt():
	if currentmode == movemode.HURT:
		pass
	else:
		currentmode = movemode.HURT
		if velocity != Vector2(0,0):
			var instvel = velocity
			velocity = -instvel
			velocity.x = -facing.x * SPEED * 3
		else:
			velocity = -facing * SPEED
		globalhealth -= Globals.damage_amount

func normal_mode():
	currentmode = movemode.NORMAL

func attacking():
	attacktrack = true
	var attack = attackpreload.instantiate()
	attack_cooldown.wait_time = 0.3
	if charged == true:
		attack.charged = true
		attack_cooldown.wait_time = 0.6
	if facing == Vector2.LEFT:
		attack.rotation_degrees = 180
		attack.position = Vector2(-50,0)
	elif facing == Vector2.RIGHT:
		attack.rotation_degrees = 0
		attack.position = Vector2(50,0)
	add_child(attack)
	charge_timeout.start()
	attack_cooldown.start()

func endgame():
	currentmode = movemode.END

func _on_charge_timeout_timeout() -> void:
	charged = false
	charge_animation.visible = false

func _on_killzone_body_entered(body: Node2D) -> void:
	if body == self:
		globalhealth -= 1
		death_buffer_timer.start()

func _on_death_buffer_timer_timeout() -> void:
	position = Globals.nearest_respawn
	is_on_floor()

func _on_replenish_timer_timeout() -> void:
	globalcharge += 1
	globalhealth += 1

func _on_attack_cooldown_timeout() -> void:
	attacktrack = false

func charge_visuals():
	charge_animation.visible = true
	charge_animation.play("default")

func update_animation():
	animation_tree["parameters/hurt/blend_position"] = facing.x
	animation_tree["parameters/land/blend_position"] = facing.x
	animation_tree["parameters/idle/blend_position"] = facing.x
	animation_tree["parameters/airborne/blend_position"] = facing.x
	animation_tree["parameters/airborne/facing_left/blend_position"] = velocity.y
	animation_tree["parameters/airborne/facing_right/blend_position"] = velocity.y
	animation_tree["parameters/walk/blend_position"] = facing.x
	animation_tree["parameters/attack/blend_position"] = facing.x
	#directing to blending modes
	if currentmode == movemode.HURT:
		state_machine.travel("hurt")
	else:
		if attacktrack == true:
			state_machine.travel("attack")
		else:
			if is_on_floor():
				if velocity == Vector2.ZERO:
					state_machine.travel("idle")
				else:
					state_machine.travel("walk")
			else:
				state_machine.travel("airborne")
