extends Node3D

@onready var door: StaticBody3D = $singelo_door/door # گرفتن نود در برای تغییر روتیشن ان
@export var open_door_key : Key = KEY_E # کلید باز و بسته کردن در
@export var player_name : String = "first-person-3d-control" # اسم پلیری  که میتواند در را باز و بسته کن

enum door_statos {open , close , not_action}
var door_process : door_statos = door_statos.not_action

# متقییر های برای کنترل کردن محدوده ای در که ایا پلیر داخل است یا نه 
var in_area : bool = false

#مقادیر چرخش در 
const door_is_open : float =90
const door_is_close : float = 0


func _process(delta: float) -> void:
	
	# تغقییر چرخش در
	match door_process :
		door_statos.close : 
			door.rotation_degrees.y = lerp(door.rotation_degrees.y , door_is_open , 3 * delta)
		door_statos.open : 
			door.rotation_degrees.y = lerp(door.rotation_degrees.y , door_is_close , 3 * delta)
		_:
			door_process = door_statos.not_action
	
	# شرط باز شدن در
	if Input.is_key_pressed(open_door_key) and in_area ==  true and door.rotation_degrees.y < 1 : 
		door_process = door_statos.close
	# شر بسته شدن در 
	if Input.is_key_pressed(open_door_key) and in_area == true  and door.rotation_degrees.y > 89 : 
		door_process = door_statos.open
	
#چک کردن اینکه ایا پلیر در محدوه ای در است 
func _on_area_body_entered(body: Node3D) -> void:
	if body.name == player_name : 
		in_area = true

# چک کردن که اگر پلیر از محدوده ای در خارج شد عمل نکنند
func _on_area_body_exited(body: Node3D) -> void:
	if body.name == player_name : 
		in_area = false
