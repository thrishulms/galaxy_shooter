extends CharacterBody2D

const SPEED = 300.0
var is_dragging = false
var event_location = Vector2.ZERO;

var sensitivity: float = 0.2
var gravity: Vector3

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

# movement code drag logic
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		is_dragging = event.is_pressed()
		event_location = event.global_position
	if event is InputEventScreenDrag:
		is_dragging = true
		event_location = get_global_mouse_position()


# only for debugging
func debug_keyboard_input_movement(delta: float) -> void:
	var direction = Input.get_vector("Left", "Right", "Up" , "Down")
	velocity = direction * SPEED
	move_and_collide(velocity * delta)

func _process(delta: float) -> void:
	gravity = Input.get_gravity()
	if(gravity != Vector3.ZERO):
		var direction = Vector2(gravity.x * sensitivity, -gravity.y * sensitivity)
		velocity = direction * SPEED
		move_and_collide(velocity * delta)
	else:
		debug_keyboard_input_movement(delta)
