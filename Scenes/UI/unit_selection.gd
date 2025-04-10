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

var descriptions = {"Scout":"Fast moving wizard with low health. I'll learn how to cast fireball one day...",
					"Autorifle":"Fires fast, can hit many targets with machine gun. Dark magic was worth it",
					"Rifleman":"Core, decent dps frontline unit. Had to pay for uni somehow...",
					"Sniper":"Snipers pick off targets from afar with precision. No relation to shopkeep",
					"Hoplite":"High health melee tank unit. Will mash your face in",
					"Caster":"Casts fireball repeatedly. Because fireballs solve problems",
					# Ability Descriptions
					"Missile Launch":"KABOOM the lizards where you click! Works in adjacent lanes",
					"Shotgun":"Summon a big boom stick to send your enemies to their god(s)",
					"Anti-Dying Circle":"Manifest a big ol' anti death circle! note: does not prevent injury",
					"Flame Rain":"Summon a rain of fireballs to destroy your enemies!"}


func _ready() -> void:
	$UnitDescription.hide()
	$UnitDescription/HBoxContainer/HBoxContainer2/UsesLeft.hide()
	
	# Enable buttons of unlocked units
	$"All units/Unit2/UnitSelect2".disabled = !Global.unlockedUnits.has(2)
	$"All units/Unit3/UnitSelect3".disabled = !Global.unlockedUnits.has(3)
	$"All units/Unit1/UnitSelect4".disabled = !Global.unlockedUnits.has(4)
	$"All units/Unit2/UnitSelect5".disabled = !Global.unlockedUnits.has(5)
	$"All units/Unit3/UnitSelect6".disabled = !Global.unlockedUnits.has(6)

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
	unitId = "Scout"
	icon = $"All units/Unit1/UnitSelect1".icon
	cost = 20
	unitOrAbility = 1
	

func _on_unit_select_2_pressed() -> void:
	selected = true
	unitId = "Rifleman"
	icon = $"All units/Unit2/UnitSelect2".icon
	cost = 20
	unitOrAbility = 1


func _on_unit_select_3_pressed() -> void:
	selected = true
	unitId = "Autorifle"
	icon = $"All units/Unit3/UnitSelect3".icon
	cost = 40
	unitOrAbility = 1


func _on_unit_select_4_pressed() -> void:
	selected = true
	unitId = "Sniper"
	icon = $"All units/Unit1/UnitSelect4".icon
	cost = 60
	unitOrAbility = 1
	
	
func _on_unit_select_5_pressed() -> void:
	selected = true
	unitId = "Hoplite"
	icon = $"All units/Unit2/UnitSelect5".icon
	cost = 40
	unitOrAbility = 1


func _on_unit_select_6_pressed() -> void:
	selected = true
	unitId = "Caster"
	icon = $"All units/Unit3/UnitSelect6".icon
	cost = 90
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
	cost = 80
	unitOrAbility = 2

func _on_ability_select_3_pressed() -> void:
	selected = true
	unitId = "Shotgun"
	icon = $AllAbilities/Ability1/AbilitySelect3.icon
	cost = 80
	unitOrAbility = 2
	
func _on_ability_select_2_pressed() -> void:
	selected = true
	unitId = "Anti-Dying Circle"
	icon = $AllAbilities/Ability2/AbilitySelect2.icon
	cost = 50
	unitOrAbility = 2
	
func _on_ability_select_4_pressed() -> void:
	selected = true
	unitId = "Flame Rain"
	icon = $AllAbilities/Ability2/AbilitySelect4.icon
	cost = 50
	unitOrAbility = 2

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



func show_description(name, cost):
	$UnitDescription/Name.text = name
	$UnitDescription/Description.text = descriptions[name]
	$UnitDescription/HBoxContainer/HBoxContainer/Cost.text = "Battle cost: "+str(cost)
	$UnitDescription.show()
	
func show_uses_left(name):
	$UnitDescription/HBoxContainer/HBoxContainer2/UsesLeft.text = str(Global.boughtItems[name]) + " left"
	$UnitDescription/HBoxContainer/HBoxContainer2/UsesLeft.show()

func _on_unit_select_1_mouse_entered() -> void:
	show_description("Scout", 20)


func _on_unit_select_2_mouse_entered() -> void:
	show_description("Rifleman", 20)


func _on_unit_select_3_mouse_entered() -> void:
	show_description("Autorifle", 40)


func _on_unit_select_4_mouse_entered() -> void:
	show_description("Sniper", 60)

func _on_unit_select_5_mouse_entered() -> void:
	show_description("Hoplite", 40)


func _on_unit_select_6_mouse_entered() -> void:
	show_description("Caster", 90)


func _on_ability_select_1_mouse_entered() -> void:
	show_description("Missile Launch", 50)
	show_uses_left("Missile Launch")
	
func _on_ability_select_2_mouse_entered() -> void:
	show_description("Anti-Dying Circle", 50)
	show_uses_left("Anti-Dying Circle")

func _on_ability_select_3_mouse_entered() -> void:
	show_description("Shotgun", 80)
	show_uses_left("Shotgun")

func _on_ability_select_4_mouse_entered() -> void:
	show_description("Flame Rain", 80)
	show_uses_left("Flame Rain")

	
func _on_button_mouse_exited() -> void:
	$UnitDescription/HBoxContainer/HBoxContainer2/UsesLeft.hide()
	$UnitDescription.hide()
