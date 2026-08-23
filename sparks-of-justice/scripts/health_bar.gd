extends ProgressBar

@onready var timer: Timer = $Timer

var health = 0

func init_health(_health):
	health = _health
	max_value = _health
	value = health

func set_health(new_health):
	health = min(max_value, new_health)
	value = health
	
