extends CanvasLayer

@onready var progress_bar: ProgressBar = $Control_UHD/ProgressBar
@onready var control_game_over: Control = $Control_GameOver
@onready var label_coin: Label = $Control_UHD/Label_Coin
@onready var control_pause: Control = $Control_Pause
@onready var control_level_completed: Control = $Control_LevelCompleted
@onready var control_finish: Control = $Control_Finish


func _ready() -> void:
	control_game_over.visible = false
	GameManager.playerHealthUpdate_signal.connect(UpdatedHealthBar)
	
	progress_bar.value = 100
	GameManager.gameOver_signal.connect(ShowGameOverScreen)
	
	label_coin.text = '0'
	GameManager.playerCoinUpdated_signal.connect(UpdatedCoinLabel)
	
	control_pause.visible = false
	GameManager.togglePause_signal.connect(TogglePauseScreen)
	
	control_level_completed.visible = false
	GameManager.LevelCompleted_signal.connect(ShowLevelCompletetdScreen)
	
	control_finish.visible = false
	GameManager.gameFinish_signal.connect(ShowFinishiScreen)
	
func ShowFinishiScreen():
	control_finish.visible = true

func ShowLevelCompletetdScreen():
	control_level_completed.visible = true

func TogglePauseScreen(isPause : bool):
	control_pause.visible = isPause

func UpdatedHealthBar(currentHealth : int , maxHealth : int):
	progress_bar.value = float(currentHealth) / float(maxHealth) * 100

func ShowGameOverScreen():
	control_game_over.visible = true

func _on_button_restart_pressed() -> void:
	if get_tree().paused == true:
		GameManager.TogglePause()
	get_tree().reload_current_scene()

func UpdatedCoinLabel(newValue):
	label_coin.text = str(newValue)

func _on_button_resume_pressed() -> void:
	GameManager.TogglePause()

func _on_button_next_level_pressed() -> void:
	GameManager.GoToNextLevel()




func _on_button_main_menu_pressed() -> void:
	if get_tree().paused == true:
		GameManager.TogglePause()
	GameManager.GoToMainMenu()
