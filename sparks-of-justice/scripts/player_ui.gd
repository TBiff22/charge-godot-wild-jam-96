extends Node2D

@export var position_tracker: Node2D
@export var player : Node2D
@onready var health_bar: ProgressBar = $"health bar/health bar2"
@onready var charge_bar: ProgressBar = $"charge bar/charge bar"
@onready var timer_label: RichTextLabel = $"other info/timer label"

var time = 0
var minutes : int = 0
var seconds : int = 0

func _ready():
	health_bar.init_health(player.globalhealth)
	charge_bar.init_health(player.globalcharge)

func _process(delta: float) -> void:
	time += delta
	update_time()
	var secondtext = str(seconds)
	if seconds < 10:
		secondtext = "0" + str(seconds)
	timer_label.text = "Time Taken\n" + str(minutes) + ":" + secondtext
	if global_position.y <= 177:
		global_position = position_tracker.global_position
	else:
		global_position.y = 177
	set_health(player.health)
	set_charge(player.charge)

func update_time():
	minutes = int(time/60)
	seconds = int(time) - 60 * minutes

func set_health(value):
	health_bar.set_health(value)
	health_bar.health = player.health

func set_charge(value):
	charge_bar.set_health(value)
	charge_bar.health = player.globalcharge
