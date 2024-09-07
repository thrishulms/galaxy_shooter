extends CharacterBody2D

const SPEED = 300.0
var is_dragging = false
var event_location = 0;

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		is_dragging = event.is_pressed()
		event_location = event.global_position
	if event is InputEventScreenDrag:
		is_dragging = true
		event_location = get_global_mouse_position()

func _process(delta: float) -> void:
	if is_dragging:
		$Sprite2D.global_position = event_location
