extends CharacterBody3D

@export var score: int = 0
@export var coins: int = 0
@export var chests: int = 0
@export var diamonds: int = 0
@onready var score_label = get_node("../CanvasLayer/ScoreLabel")
@onready var coin_label = get_node("../CanvasLayer/CoinsLabel")
@onready var treasure_label = get_node("../CanvasLayer/ChestsLabel")
@onready var diamond_label = get_node("../CanvasLayer/DiamondsLabel")

@export var look_speed : float = 0.002
@export var base_speed : float = 7.0
@export var jump_velocity : float = 4.5
@export var sprint_speed : float = 10.0

@export var move_left : String = "move_left"
@export var move_right : String = "move_right"
@export var move_forward : String = "move_forward"
@export var move_back : String = "move_back"
@export var jump : String = "jump"
@export var sprint : String = "sprint"

var mouse_captured : bool = false
var look_rotation : Vector2
var move_speed : float = 0.0

@onready var head: Node3D = $Head
@onready var collider: CollisionShape3D = $Collider

func increase_score(amount: int = 1):
	score += amount
	score_label.text = "Score: " + str(score)
	Global.final_score = score_label.text

func counter(type: String):
	if type == "coin":
		coins += 1
		coin_label.text = "Coins: " + str(coins) +"/10"
	elif type == "chest":
		chests += 1
		treasure_label.text = "Treasures: " + str(chests) +"/5"
	elif type == "diamond":
		diamonds += 1
		diamond_label.text = "Diamonds: " + str(diamonds) +"/3"

func _ready() -> void:
	look_rotation.y = rotation.y
	look_rotation.x = head.rotation.x

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		capture_mouse()
	if Input.is_key_pressed(KEY_ESCAPE):
		release_mouse()
	if mouse_captured and event is InputEventMouseMotion:
		rotate_look(event.relative)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed(jump) and is_on_floor():
		velocity.y = jump_velocity
	if Input.is_action_pressed(sprint):
		move_speed = sprint_speed
	else:
		move_speed = base_speed
	var input_dir := Input.get_vector(move_left, move_right, move_forward, move_back)
	var move_dir := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if move_dir:
		velocity.x = move_dir.x * move_speed
		velocity.z = move_dir.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)
	move_and_slide()

func rotate_look(rot_input : Vector2):
	look_rotation.x -= rot_input.y * look_speed
	look_rotation.x = clamp(look_rotation.x, deg_to_rad(-85), deg_to_rad(85))
	look_rotation.y -= rot_input.x * look_speed
	transform.basis = Basis()
	rotate_y(look_rotation.y)
	head.transform.basis = Basis()
	head.rotate_x(look_rotation.x)

func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false
