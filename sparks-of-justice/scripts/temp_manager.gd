extends Node

@export var data = room_data

var enemyno = 2
var deathscreen = preload("res://scenes/death_screen.tscn")
var winscene = preload("res://scenes/win_scene.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.game_end.connect(ending)
	Globals.enemydown.connect(minuscount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enemyno == 0:
		Globals.outcome = Globals.outcomes.WIN
		Globals.game_end.emit()

func ending():
	if Globals.outcome == Globals.outcomes.LOSE:
		add_child(deathscreen.instantiate())
	elif Globals.outcome == Globals.outcomes.WIN:
		add_child(winscene.instantiate())
	get_tree().paused = true

func minuscount():
	enemyno -= 1
