extends Resource
class_name room_data

@export var enemyspawns : Dictionary[String, Vector2] = {
	"test enemy" : Vector2(0,0),
	"hi" : Vector2(0,1)
}

@export var next_room : String = "empty"
@export var prev_room : String = "empty"
