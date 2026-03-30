extends Node

signal  playerHealthUpdate_signal(newValue,maxValue)
signal  playerCoinUpdated_signal(newValue)
signal  gameOver_signal()
signal  togglePause_signal(isPaused)
signal  LevelCompleted_signal()
signal  gameFinish_signal()

var sceneArray = ["uid://02mre1g3jo5b" , "uid://40ocp32tp10x" , "uid://dtyyguy45s8wa" , "uid://b770xe7stsdar"]

var isPause = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		TogglePause()

func TogglePause():
	isPause = !isPause
	get_tree().paused=isPause
	emit_signal("togglePause_signal",isPause)
	
func PlayerCoinUpdated(newValue : int):
	emit_signal("playerCoinUpdated_signal",newValue)

func PlayerHealthUpdate(newValue : int , maxValue : int):
	emit_signal("playerHealthUpdate_signal",newValue,maxValue)

func PlayerIsDead():
	emit_signal("gameOver_signal")

func EnemiesAreDead():
	if TryGetNextLevelIndex() == -1:
		emit_signal("gameFinish_signal")
	else:
		emit_signal("LevelCompleted_signal")
	
func GoToNextLevel():
	var nextLevelIndex = TryGetNextLevelIndex()
	if nextLevelIndex != -1:
		var nextLevelUID = sceneArray[nextLevelIndex]
		get_tree().change_scene_to_file(nextLevelUID)


func TryGetNextLevelIndex() -> int:
	var currentScene = get_tree().current_scene
	var currentScenePath = currentScene.scene_file_path
	var currentSceneUID = ResourceUID.path_to_uid(currentScenePath)
	var currentSceneIndex = sceneArray.find(currentSceneUID)
	
	if currentSceneIndex != -1:
		var nextSceneIndex = currentSceneIndex + 1
		if nextSceneIndex < sceneArray.size():
			return nextSceneIndex
	return -1
	
func GoToMainMenu():
	get_tree().change_scene_to_file(sceneArray[0])
