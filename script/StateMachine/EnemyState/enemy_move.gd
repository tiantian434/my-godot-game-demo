extends State
@onready var navigation_agent_2d: NavigationAgent2D = $"../../NavigationAgent2D"
@onready var player_pos_update_timer: Timer = $"../../PlayerPosUpdateTimer"

var direction : Vector2
var speed : float
const SPEED_MAX = 50
const SPEED_MIN = 20

func Update():
	super.Update()
	character.UpdateAnimate()
	speed = randf_range(SPEED_MIN,SPEED_MAX)
	
func UpdatePhysics(delta : float):
	super.UpdatePhysics(delta)
	
	if character.player.isDead == true:
		parentStateMachine.SwichTo("Idle")
		return
	
	direction = character.global_position.direction_to(navigation_agent_2d.get_next_path_position())

	if navigation_agent_2d.is_target_reached() == false:
		character.velocity = character.velocity.lerp(direction * speed , delta)
		character.move_and_slide()


func _on_player_pos_update_timer_timeout() -> void:
	navigation_agent_2d.target_position = character.player.global_position

func Enter():
	super.Enter()
	player_pos_update_timer.start()
	
func exit():
	super.Exit()
	player_pos_update_timer.stop()


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	if parentStateMachine.currentState == self && navigation_agent_2d.is_target_reached() == false:
		character.velocity += safe_velocity * get_physics_process_delta_time()
