extends Control

var scene_path_to_load
var current_task
var _player_name = "Player"
enum Task { HOST, JOIN, NONE }

func _ready():
	$MarginContainer/Buttons/HostButton.grab_focus()
	for button in $MarginContainer/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load, button.task])

func _on_Button_pressed(scene_to_load, task):
	scene_path_to_load = scene_to_load
	if task == str('Host'):
		current_task = Task.HOST
	elif task == str('Join'):
		current_task = Task.JOIN
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	match current_task:
		#task.NONE:
		Task.HOST:
			Network.create_server(str(_player_name, 1))
		Task.JOIN:
			Network.connect_to_server(str(_player_name, 2))
	get_tree().change_scene(scene_path_to_load)


func _on_HostButton_pressed():
	Network.create_server(str(_player_name, 1))


func _on_JoinButton_pressed():
	Network.connect_to_server(str(_player_name, 2))
