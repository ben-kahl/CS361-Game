extends CanvasLayer

@export var view_profile_button : Button = find_child("ViewProfile")
@export var edit_profile_button : Button = find_child("EditProfile")
@export var back_to_network_button : Button = find_child("BackNetwork")
@export var back_to_profile_button : Button = find_child("BackProfile")
@export var back_to_profile_edit_button : Button = find_child("BackProfileEdit")
@export var save_profile_button : Button = find_child("SaveInfo")

@onready var path = "res://data/profile_data.json"
@onready var profile_info = FileAccess.get_file_as_string(path)

# Called when the node enters the scene tree for the first time.
func _ready():
	view_profile_button.pressed.connect(view_profile)
	edit_profile_button.pressed.connect(edit_profile)
	back_to_network_button.pressed.connect(back_to_network)
	back_to_profile_button.pressed.connect(back_to_profile)
	back_to_profile_edit_button.pressed.connect(back_to_profile_edit)
	save_profile_button.pressed.connect(save_profile)
	$ColorRect/ViewProfileInfo.hide()
	$ColorRect/EditProfileInfo.hide()
	$ColorRect/Select.show()
	pass # Replace with function body.

func view_profile():
	profile_info = FileAccess.get_file_as_string(path)
	var json = JSON.new()
	var profile_json = json.parse_string(profile_info)
	$ColorRect/Select.hide()
	$ColorRect/ViewProfileInfo.show()
	$ColorRect/ViewProfileInfo/PanelContainer/MarginContainer/VBoxContainer/UserName.text = profile_json.user_name
	$ColorRect/ViewProfileInfo/PanelContainer/MarginContainer/VBoxContainer/ProfileInfo.text = profile_json.profile_info

func edit_profile():
	$ColorRect/Select.hide()
	$ColorRect/EditProfileInfo.show()

func back_to_network():
	get_tree().change_scene_to_file("res://scenes/network_menu.tscn")

func back_to_profile():
	$ColorRect/ViewProfileInfo.hide()
	$ColorRect/Select.show()
	
func back_to_profile_edit():
	$ColorRect/EditProfileInfo.hide()
	$ColorRect/Select.show()

func save_profile():
	var json = JSON.new()
	var profile_json = json.parse_string(profile_info)
	profile_json.user_name = $ColorRect/EditProfileInfo/UserNameEdit.text
	profile_json.profile_info = $ColorRect/EditProfileInfo/ProfileInfoEdit.text
	var profile_as_string = json.stringify(profile_json)
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(profile_as_string)
