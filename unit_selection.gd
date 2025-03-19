extends Node2D


@export var unitOneIcon: CompressedTexture2D
@export var unitTwoIcon: CompressedTexture2D
@export var unitThreeIcon: CompressedTexture2D

var units = [[1,2,3],[1,2,3],[1,2,3],[1,2,3]]
var selected = false
var unitId = ""
var cost = 0
var icon


func _on_unit_1_button_pressed() -> void:
	if(selected):
		$UnitsForBattle/Unit1/Unit1Button.icon = icon
		units[0][0] = icon
		units[0][1] = unitId
		units[0][2] = cost
	selected = false

func _on_unit_2_button_pressed() -> void:
	if(selected):
		$UnitsForBattle/Unit2/Unit2Button.icon = icon
		units[1][0] = icon
		units[1][1] = unitId
		units[1][2] = cost
	selected = false


func _on_unit_3_button_pressed() -> void:
	if(selected):
		$UnitsForBattle/Unit3/Unit3Button.icon = icon
		units[2][0] = icon
		units[2][1] = unitId
		units[2][2] = cost
	selected = false


func _on_unit_4_button_pressed() -> void:
	if(selected):
		$UnitsForBattle/Unit4/Unit4Button.icon = icon
		units[3][0] = icon
		units[3][1] = unitId
		units[3][2] = cost
	selected = false


func _on_unit_select_1_pressed() -> void:
	selected = true
	unitId = "rifleman"
	icon = $"All units/Unit1/UnitSelect1".icon
	cost = 10
	

func _on_unit_select_2_pressed() -> void:
	selected = true
	unitId = "normal"
	icon = $"All units/Unit2/UnitSelect2".icon
	cost = 20


func _on_unit_select_3_pressed() -> void:
	selected = true
	unitId = "autorifleman"
	icon = $"All units/Unit3/UnitSelect3".icon
	cost = 30


func _on_unit_select_4_pressed() -> void:
	selected = true
	unitId = "someone"
	icon = $"All units/Unit4/UnitSelect4".icon
	cost = 40


func getUnits():
	return units


func _on_enter_game_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
