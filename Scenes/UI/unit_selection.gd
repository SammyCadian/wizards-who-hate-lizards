extends Control


@export var unitOneIcon: CompressedTexture2D
@export var unitTwoIcon: CompressedTexture2D
@export var unitThreeIcon: CompressedTexture2D

var units = [[0,"NO_UNIT",0],[0,"NO_UNIT",0],[0,"NO_UNIT",0],[0,"NO_UNIT",0],[0,"NO_ABILITY",0],[0,"NO_ABILITY",0]]
#var abilities = []
var selected = false
var unitId = ""
var cost = 0
var icon
var unitOrAbility = 0

signal loadBattle

func _on_unit_1_button_pressed() -> void:
	if(selected && unitOrAbility == 1):
		$UnitsForBattle/Unit1/Unit1Button.icon = icon
		units[0][0] = icon
		units[0][1] = unitId
		units[0][2] = cost
	selected = false

func _on_unit_2_button_pressed() -> void:
	if(selected && unitOrAbility == 1):
		$UnitsForBattle/Unit2/Unit2Button.icon = icon
		units[1][0] = icon
		units[1][1] = unitId
		units[1][2] = cost
	selected = false


func _on_unit_3_button_pressed() -> void:
	if(selected && unitOrAbility == 1):
		$UnitsForBattle/Unit3/Unit3Button.icon = icon
		units[2][0] = icon
		units[2][1] = unitId
		units[2][2] = cost
	selected = false


func _on_unit_4_button_pressed() -> void:
	if(selected && unitOrAbility == 1):
		$UnitsForBattle/Unit4/Unit4Button.icon = icon
		units[3][0] = icon
		units[3][1] = unitId
		units[3][2] = cost
	selected = false


func _on_unit_select_1_pressed() -> void:
	selected = true
	unitId = "scout"
	icon = $"All units/Unit1/UnitSelect1".icon
	cost = 10
	unitOrAbility = 1
	

func _on_unit_select_2_pressed() -> void:
	selected = true
	unitId = "rifleman"
	icon = $"All units/Unit2/UnitSelect2".icon
	cost = 20
	unitOrAbility = 1


func _on_unit_select_3_pressed() -> void:
	selected = true
	unitId = "autorifle"
	icon = $"All units/Unit3/UnitSelect3".icon
	cost = 30
	unitOrAbility = 1


func _on_unit_select_4_pressed() -> void:
	selected = true
	unitId = "someone"
	icon = $"All units/Unit4/UnitSelect4".icon
	cost = 40
	unitOrAbility = 1

func getUnits():
	return units

func _on_enter_game_pressed() -> void:
	loadBattle.emit()

func _on_enter_game_button_up() -> void:
	visible = false
	loadBattle.emit()


func _on_ability_select_1_pressed() -> void:
	selected = true
	unitId = "Missile Launch"
	icon = $AllAbilities/Ability1/AbilitySelect1.icon
	cost = 50
	unitOrAbility = 2
	pass # Replace with function body.


func _on_ability_1_button_pressed() -> void:
	if(selected && unitOrAbility == 2):
		$AbilitiesForBattle/Ability1/Ability1Button.icon = icon
		units[4][0] = icon
		units[4][1] = unitId
		units[4][2] = cost
	selected = false

func _on_ability_2_button_pressed() -> void:
	if(selected && unitOrAbility == 2):
		$AbilitiesForBattle/Ability2/Ability2Button.icon = icon
		units[5][0] = icon
		units[5][1] = unitId
		units[5][2] = cost
	selected = false
