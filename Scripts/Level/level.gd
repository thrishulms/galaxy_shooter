extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().quit_on_go_back = false
	get_tree().get_root().connect("go_back_requested", _handle_back_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _handle_back_button_pressed() -> void:
		get_tree().change_scene_to_file("res://Scene/main_menu.tscn")
