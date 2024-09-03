extends Control
class_name Stage_Menu
#region VARIABLES
@export var mainScene: Main_Scene
var gameVariables: Game_Variables
#-------------------------------------------------------------------------------
@export var button: Array[Button]
@export var back: Button
#endregion
#-------------------------------------------------------------------------------
#region MONOVEHAVIOUR
func Start() -> void:
	gameVariables = get_node("/root/GameVariables")
	#-------------------------------------------------------------------------------
	SetAllButtons()
	hide()
#endregion
#-------------------------------------------------------------------------------
#region BUTTON FUNCTIONS
func SetAllButtons() -> void:
	for _i in 9:
		gameVariables.SetButton(button[_i], gameVariables.CommonSelected, func():StageButton_Subited(_i), AnyButton_Canceled)
	gameVariables.SetButton(back, gameVariables.CommonSelected, BackButton_Subited, BackButton_Canceled)
#-------------------------------------------------------------------------------
func UpdateStageButtons():
	var _player: int = gameVariables.currentSaveData.playerIndex
	var _difficulty: int = gameVariables.currentSaveData.difficultyIndex
	for _i in 9:
		match(gameVariables.currentSaveData.player[_player].difficulty[_difficulty].stage[_i].mySTAGE_STATE):
			StageSaveData.STAGE_STATE.DISABLED:
				button[_i].text = "[Locked]"
			_:
				SetButtonIdiome(button[_i], _i)
#-------------------------------------------------------------------------------
func StageButton_Subited(_i:int) -> void:
	var _player: int = gameVariables.currentSaveData.playerIndex
	var _difficulty: int = gameVariables.currentSaveData.difficultyIndex
	match(gameVariables.currentSaveData.player[_player].difficulty[_difficulty].stage[_i].mySTAGE_STATE):
		StageSaveData.STAGE_STATE.DISABLED:
			gameVariables.CommonCanceled()
		_:
			hide()
			gameVariables.currentSaveData.stageIndex = _i
			mainScene.mainMenu.SetGameInfo()
			gameVariables.MoveToButton(mainScene.startMenu.start)
			mainScene.startMenu.show()
			gameVariables.CommonSubmited()
#-------------------------------------------------------------------------------
func AnyButton_Canceled() -> void:
	gameVariables.MoveToButton(back)
	gameVariables.CommonCanceled()
#-------------------------------------------------------------------------------
func BackButton_Subited() -> void:
	BackButton_Common()
	gameVariables.CommonSubmited()
#-------------------------------------------------------------------------------
func BackButton_Canceled() -> void:
	BackButton_Common()
	gameVariables.CommonCanceled()
#-------------------------------------------------------------------------------
func BackButton_Common() -> void:
	hide()
	gameVariables.MoveToButton(mainScene.mainMenu.button[0])
	mainScene.mainMenu.show()
#endregion
#-------------------------------------------------------------------------------
#region IDIOME FUNCTIONS
func SetIdiome():
	back.text = tr("optionMenu_back")
	for _i in button.size():
		SetButtonIdiome(button[_i], _i)
#-------------------------------------------------------------------------------
func SetButtonIdiome(_b:Button, _i:int):
	_b.text = tr("stageMenu_button"+str(_i))
#endregion
#-------------------------------------------------------------------------------
