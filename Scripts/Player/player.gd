extends CharacterBody2D

const SPEED = 300.0
var is_dragging = false
var event_location = Vector2.ZERO;

var projectile_scene = preload("res://Scene/bullet.tscn")

func _ready() -> void:
	_firerateTime_Instantiate()

#fire rate and projectile code
func _firerateTime_Instantiate(): 
	var fire_rate_timer = $FireRateTimer
	fire_rate_timer.timeout.connect(_on_FireRateTimer_timeout)
	fire_rate_timer.start()

func _on_FireRateTimer_timeout() -> void:
	var projectile = projectile_scene.instantiate()
	projectile.position = $MainGunTriggerPoint.global_position
	get_tree().root.add_child(projectile)
	projectile.direction = Vector2(0, -1)

# movement code
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		is_dragging = event.is_pressed()
		event_location = event.global_position
	if event is InputEventScreenDrag:
		is_dragging = true
		event_location = get_global_mouse_position()

func _process(delta: float) -> void:
	if is_dragging && event_location != Vector2.ZERO:
		global_position = event_location
