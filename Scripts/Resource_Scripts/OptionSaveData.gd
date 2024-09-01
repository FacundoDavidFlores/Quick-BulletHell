extends Resource
class_name OptionSaveData
#-------------------------------------------------------------------------------
@export_range(0, 1, 0.1) var masterVolumen: float = 1.0
@export_range(0, 1, 0.1) var sfxVolumen: float = 1.0
@export_range(0, 1, 0.1) var bgmVolumen: float = 1.0
#-------------------------------------------------------------------------------
@export var vsync: bool = false
#-------------------------------------------------------------------------------
@export var fullscreen: bool = false
#-------------------------------------------------------------------------------
@export var borderless: bool = false
#-------------------------------------------------------------------------------
@export var resolutionIndex: int = 3
#-------------------------------------------------------------------------------
@export var idiomeIndex: int = 0
#-------------------------------------------------------------------------------
@export var saveIndex: int = 0
#-------------------------------------------------------------------------------
