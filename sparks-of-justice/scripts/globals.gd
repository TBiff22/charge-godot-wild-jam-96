extends Node

signal player_hurt
signal game_end
signal enemydown
signal settings
signal settings_back

var save_path = "user://savedata.save"

enum outcomes {LOSE, WIN, NA}

var nearest_respawn : Vector2 = Vector2(0,0)
var outcome = outcomes.NA
var damage_amount: int = 0
var player_pos = Vector2(0,0)

var hits: int = 0
var charge_atks: int = 0
var time_taken: int = 0
var enemynum: int = 10
var fall_track: int = 0
var score: int = 0

var volumes: Array[float] = [1.0, 1.0, 1.0]

var player_stats: Dictionary[String, Variant] = {
	"name": "name",
	"health": 20,
	"atk": 2,
	"def": 2,
	"charge" : 10
}

func game_ended():
	score_calc()
	print(score)

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(player_stats)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		player_stats = file.get_var()
	else:
		print("no data")

func score_calc():
	if time_taken <= 120:
		score += 20
	elif time_taken <= 180 and time_taken > 120:
		score += 10
	else:
		pass
	score += 40 - 4 * enemynum
	if fall_track == 0:
		score += 10
	elif fall_track == 1:
		score += 5
	else:
		pass
	if charge_atks >= 5:
		score += 10
	elif charge_atks >= 2 and charge_atks < 5:
		score += 5
	else:
		pass
	score += player_stats["health"] * 0.5
	print(score)
		
