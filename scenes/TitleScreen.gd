extends Control

var scene_path_to_load
var current_task
var _player_name = "Player"
enum Task { NEW, NONE }

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/Menu/CenterRow/Buttons/NewGameButton.grab_focus()
	for button in $MarginContainer/Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load, button.task])


func _on_Button_pressed(scene_to_load, task):
	scene_path_to_load = scene_to_load
	if task == str('New'):
		current_task = Task.NEW
	$FadeIn.show()
	$FadeIn.fade_in()


func _on_FadeIn_fade_finished():
	match current_task:
		#task.NONE:
		Task.NEW:
			Network.create_server(str(_player_name, 1))
	get_tree().change_scene(scene_path_to_load)
