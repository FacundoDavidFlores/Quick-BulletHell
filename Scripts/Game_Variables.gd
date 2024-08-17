extends Node
class_name Game_Variables
#region VARIABLES
#-------------------------------------------------------------------------------
@export var optionMenu: Option_Menu
#-------------------------------------------------------------------------------
@export_group("Audio and SFXs")
@export var sfx_Selected : AudioStreamPlayer
@export var sfx_Submited : AudioStreamPlayer
@export var sfx_Canceled : AudioStreamPlayer
@export var bgmPlayer : AudioStreamPlayer
var playPosition: float = 0.0
@export var bgmStage1 : AudioStreamMP3
@export var bgmTitle : AudioStreamMP3
#-------------------------------------------------------------------------------
const cancelInput: String = "ui_cancel"
#-------------------------------------------------------------------------------
const saveData_name : String = "Save"
const saveData_ext : String = ".tres"
const saveData_path : String = "user://Save/"
var currentSaveData : SaveData;
#-------------------------------------------------------------------------------
const titleScene_Path: StringName = "res://Nodes/Scenes/title_scene.tscn"
const mainScene_Path: StringName = "res://Nodes/Scenes/main_scene.tscn"
const gameScene_Path: StringName = "res://Nodes/Scenes/game_scene.tscn"
#-------------------------------------------------------------------------------
@export var fps: Label
#-------------------------------------------------------------------------------
var maxSave: int = 9
#endregion
#-------------------------------------------------------------------------------
#region MONOBEHAVIOUR
func _ready():
	optionMenu.Start()
#-------------------------------------------------------------------------------
func _process(_delta:float):
	#Set_FullScreen()
	#Set_Vsync()
	#Set_MouseMode()
	#ResetGame()
	fps.text = PlayerInfo()
#endregion
#-------------------------------------------------------------------------------
#region PLAYER DATA SAVE SYSTEM
#-------------------------------------------------------------------------------
func Save_SaveData(_sd:SaveData, _i:int) -> void:
	DirAccess.make_dir_absolute(saveData_path)
	ResourceSaver.save(_sd, Get_SaveDataPath(_i))
#-------------------------------------------------------------------------------
func Delete_SaveData(_i:int) -> void:
	var _path: String = Get_SaveDataPath(_i)
	if(ResourceLoader.exists(_path)):
		DirAccess.remove_absolute(_path)
#-------------------------------------------------------------------------------
func Load_SaveData(_i:int) -> SaveData:
	var _path: String = Get_SaveDataPath(_i)
	if(ResourceLoader.exists(_path)):
		return load(_path) as SaveData
	else:
		var _saveData: SaveData = SaveData.new()
		return _saveData
#-------------------------------------------------------------------------------
func Get_SaveDataPath(_i:int) -> String:
	var _path: String = saveData_path+saveData_name+str(_i)+saveData_ext
	return _path
#endregion
#-------------------------------------------------------------------------------
#region UI FUNCTIONS
func PlayerInfo() -> String:
	var _s: String = str(Engine.get_frames_per_second()) + " fps.\n"
	return _s
#endregion
#-------------------------------------------------------------------------------
#region SET THE BUTTONS SIGNALS
func SetButton(_b:Button, _selected:Callable, _submited:Callable, _canceled:Callable) -> void:
	_b.focus_entered.connect(_selected)
	_b.pressed.connect(_submited)
	_b.gui_input.connect(_canceled)
	#_b.mouse_entered.connect(func():_b.grab_focus())
#-------------------------------------------------------------------------------
func DisconnectButton(_b:Button) -> void:
	DisconnectAll(_b.focus_entered)
	DisconnectAll(_b.pressed)
	DisconnectAll(_b.gui_input)
#-------------------------------------------------------------------------------
func DisconnectAll(_signal:Signal):
	var _dictionaryArray : Array = _signal.get_connections()
	for _dictionary in _dictionaryArray:
		_signal.disconnect(_dictionary["callable"])
#-------------------------------------------------------------------------------
func SetOptionButtons(_ob:OptionButton, _selected:Callable, _submited:Callable, _canceled:Callable) -> void:
	_ob.focus_entered.connect(_selected)
	_ob.item_selected.connect(_submited)
	_ob.gui_input.connect(_canceled)
	#_ob.mouse_entered.connect(func():_ob.grab_focus())
#-------------------------------------------------------------------------------
func OptionButtons_AddSubmited(_ob:OptionButton, _submited:Callable):
	_ob.item_selected.connect(_submited)
#-------------------------------------------------------------------------------
func SetCheckButton(_cb:CheckButton, _selected:Callable, _submited:Callable, _canceled:Callable) -> void:
	_cb.focus_entered.connect(_selected)
	_cb.toggled.connect(_submited)
	_cb.gui_input.connect(_canceled)
	#_cb.mouse_entered.connect(func():_cb.grab_focus())
#-------------------------------------------------------------------------------
func SetSlider(_sl:Slider,  _selected:Callable,  _submited:Callable,  _canceled:Callable) -> void:
	_sl.focus_entered.connect(_selected)
	_sl.value_changed.connect(_submited)
	_sl.gui_input.connect(_canceled)
	#_sl.mouse_entered.connect(func():_sl.grab_focus())
#endregion
#-------------------------------------------------------------------------------
#region UI COMMON FUNCTIONALITY
func MoveToButton(_b:Button) -> void:
	_b.grab_focus()
#-------------------------------------------------------------------------------
func MoveToLastButton(_b:Array[Button]) -> void:
	_b[_b.size()-1].grab_focus()
#-------------------------------------------------------------------------------
func PlayBGM(_bgm:AudioStreamMP3) -> void:
	bgmPlayer.stream = _bgm
	bgmPlayer.play()
#-------------------------------------------------------------------------------
func CommonSelected() -> void:
	sfx_Selected.play()
#-------------------------------------------------------------------------------
func CommonSubmited() -> void:
	sfx_Submited.play()
#-------------------------------------------------------------------------------
func CommonCanceled() -> void:
	sfx_Canceled.play()
#-------------------------------------------------------------------------------
func AnyControl_Canceled(_event:InputEvent) -> void:
	if(_event.is_action_pressed(cancelInput)):
		CommonCanceled()
#endregion
#-------------------------------------------------------------------------------
#region DEBUG INPUTS
func Set_FullScreen() -> void:
	if(Input.is_action_just_pressed("debug_Fullscreen")):
		var _wm: DisplayServer.WindowMode = DisplayServer.window_get_mode()
		if(_wm == DisplayServer.WINDOW_MODE_FULLSCREEN):
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
#-------------------------------------------------------------------------------
func Set_Vsync() -> void:
	if(Input.is_action_just_pressed("debug_Vsync")):
		var _vs: DisplayServer.VSyncMode = DisplayServer.window_get_vsync_mode()
		if(_vs == DisplayServer.VSYNC_DISABLED):
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		elif(_vs == DisplayServer.VSYNC_ENABLED):
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
#-------------------------------------------------------------------------------
func Set_MouseMode() -> void:
	if(Input.is_action_just_pressed("debug_MouseMode")):
		var _mm: Input.MouseMode = Input.mouse_mode
		if(_mm == Input.MOUSE_MODE_VISIBLE):
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		elif(_mm == Input.MOUSE_MODE_CAPTURED):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
#-------------------------------------------------------------------------------
func ResetGame() -> void:
	if(Input.is_action_just_pressed("debug_Reset")):
		get_tree().reload_current_scene()
#endregion
#-------------------------------------------------------------------------------
