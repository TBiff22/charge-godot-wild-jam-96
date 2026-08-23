@tool
extends Node

@export var bgm : Node
@export var end_ease_out : Timer
@export var menu_positioning : Node2D
@export var player : Node2D
var deathscreen = preload("res://scenes/death_screen.tscn")
var winscene = preload("res://scenes/win_scene.tscn")
var pausescreen = preload("res://scenes/pause_menu.tscn")

var enemyno = 0

func _ready():
	bgm.play(4.0)
	process_mode = PROCESS_MODE_ALWAYS
	enemy_count()
	Globals.enemydown.connect(minuscount)
	Globals.game_end.connect(end_cutscene)
	end_ease_out.timeout.connect(ending)

func _process(delta):
	var bgm_time = bgm.get_playback_position()
	if bgm_time >= 100.0:
		bgm.play(4.0)

func enemy_count():
	pass
	#var enemy_scene_loader = room_database.enemyspawns.keys()
	#for enemy in enemy_scene_loader:
		#enemyno += 1
func pause_game():
	get_tree().paused = true
	var pausescene = pausescreen.instantiate()
	pausescene.position = menu_positioning.position
	add_child(pausescene)

func end_cutscene():
	end_ease_out.start()

func ending():
	if Globals.outcome == Globals.outcomes.LOSE:
		bgm.stop
		var deathscene = deathscreen.instantiate()
		deathscene.position = menu_positioning.position
		add_child(deathscene)
	elif Globals.outcome == Globals.outcomes.WIN:
		bgm.stop
		var winning = winscene.instantiate()
		winning.position = menu_positioning.position
		add_child(winning)
	get_tree().paused = true

func minuscount():
	enemyno -= 1
	print(enemyno)
	if enemyno == 0:
		print("end")
		Globals.outcome = Globals.outcomes.LOSE
		Globals.game_end.emit()
