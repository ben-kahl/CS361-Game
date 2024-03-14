extends HTTPRequest

@onready var player_data = FileAccess.get_file_as_string("res://data/profile_data.json")

@export var retrieved_player_data : JSON

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func signup_player():
	player_data = FileAccess.get_file_as_string("res://data/profile_data.json")
	var http_request = HTTPRequest.new()
	add_child(http_request)
	var error = http_request.request("http://127.0.0.1:5011/api/signup", [], HTTPClient.METHOD_POST, player_data)
	if error != OK:
		push_error("An error occured in the HTTP request.")

func login_player():
	player_data = FileAccess.get_file_as_string("res://data/profile_data.json")
	var http_request = HTTPRequest.new()
	add_child(http_request)
	var error = http_request.request("http://127.0.0.1:5011/api/login", [], HTTPClient.METHOD_POST, player_data)
	if error != OK:
		push_error("An error occured in the HTTP request.")
	

func _on_request_completed(result, response_code, headers, body):
	#var json = JSON.new()
	#json.parse(body.get_string_from_utf8())
	#retrieved_player_data = json.get_data()
	#print(retrieved_player_data)
	print(result)
