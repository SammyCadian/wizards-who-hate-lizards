extends Control

signal unitButtonPressed(pressedUnitID: String, cost: int)
signal abilityButtonPressed(pressedAbilityID: String, cost: int)

@export var incomeTime = 1.5 # Timer between getting more magic points
var magicPoints = 20 # Track the number of magic points, as displayed in the U.I

# Units in each button, global script should update these as the player unlocks/selects other units outside of battle
@export var unitOneIcon: CompressedTexture2D
@export var unitTwoIcon: CompressedTexture2D
@export var unitThreeIcon: CompressedTexture2D
# @export var unitFour = "FOURTH_UNIT"

#Holds IDs for units and abilities
var units = []
var abilities = []
var costs = [0, 0, 0, 0, 0, 0]
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

#Load units in for testing purposes
func testLoad():
	receiveUnit(unitOneIcon, "scout", 10)
	receiveUnit(unitTwoIcon, "rifleman", 20)
	receiveUnit(unitThreeIcon, "autorifle", 40)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#testLoad()
	$UnitDescription.hide()
	$UnitDescription/HBoxContainer/HBoxContainer2/UsesLeft.hide()
	$IncomeTimer.set_wait_time(incomeTime/100)
	$IncomeTimer.start()
	updatePoints()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updatePoints():
	$PointsLabel.text = str(magicPoints)

#Load a unit ID and button icon into the UI
func receiveUnit(icon: CompressedTexture2D, unitID: String, unitCost: int):
	units.append(unitID)
	match units.size():
		1:
			$Units/Column1/UnitOne.icon = icon
			$Units/Column1/UnitOne.disabled = false
			costs[0] = unitCost
		2:
			$Units/Column1/UnitTwo.icon = icon
			$Units/Column1/UnitTwo.disabled = false
			costs[1] = unitCost
		3:
			$Units/Column2/UnitThree.icon = icon
			$Units/Column2/UnitThree.disabled = false
			costs[2] = unitCost
		4:
			$Units/Column2/UnitFour.icon = icon
			$Units/Column2/UnitFour.disabled = false
			costs[3] = unitCost
	pass

func receiveAbility(icon: CompressedTexture2D, powerID: String, powerCost: int):
	abilities.append(powerID)
	match abilities.size():
		1:
			$Abilities/Ability1.icon = icon
			$Abilities/Ability1.disabled = false
			costs[4] = powerCost
		2:
			$Abilities/Ability2.icon = icon
			$Abilities/Ability2.disabled = false
			costs[5] = powerCost
	pass
	
#signal functions
func _on_income_timer_timeout() -> void:
	if($IncomeVisual.value == 100):
		$IncomeVisual.value = 0
		magicPoints += 10
		updatePoints()
	
	$IncomeVisual.value += 1
	pass # Replace with function body.

func _on_unit_one_pressed() -> void:
	if (magicPoints >= costs[0]):
		unitButtonPressed.emit(units[0], costs[0])

func _on_unit_two_pressed() -> void:
	if (magicPoints >= costs[1]):
		unitButtonPressed.emit(units[1], costs[1])

func _on_unit_three_pressed() -> void:
	if (magicPoints >= costs[2]):
		unitButtonPressed.emit(units[2], costs[2])

func _on_unit_four_pressed() -> void:
	if (magicPoints >= costs[3]):
		unitButtonPressed.emit(units[3], costs[3])

func _on_battle_spend_points(cost: int) -> void:
	magicPoints -= cost
	updatePoints()


func _on_ability_1_pressed() -> void:
	if (magicPoints >= costs[4] && Global.boughtItems.get(abilities[0]) > 0):
		abilityButtonPressed.emit(abilities[0], costs[4])

func _on_ability_2_pressed() -> void:
	if (magicPoints >= costs[5]):
		abilityButtonPressed.emit(abilities[1], costs[5])

## TO DISPLAY DESCRIPTIONS
# Takes input to display description
func show_description(name, cost):
	$UnitDescription/Name.text = name
	$UnitDescription/Description.text = descriptions[name]
	$UnitDescription/HBoxContainer/HBoxContainer/Cost.text = "Cost: "+str(cost)
	$UnitDescription.show()
	
func show_uses_left(name):
	$UnitDescription/HBoxContainer/HBoxContainer2/UsesLeft.text = str(Global.boughtItems[name]) + " left"
	$UnitDescription/HBoxContainer/HBoxContainer2/UsesLeft.show()
	
# Unit/ability hover signals
func _on_unit_one_mouse_entered() -> void:
	if(units.size() > 0):
		show_description(units[0], costs[0])

func _on_unit_two_mouse_entered() -> void:
	if(units.size() > 1):
		show_description(units[1], costs[1])

func _on_unit_three_mouse_entered() -> void:
	if(units.size() > 2):
		show_description(units[2], costs[2])

func _on_unit_four_mouse_entered() -> void:
	if(units.size() > 3):
		show_description(units[3], costs[3])

func _on_ability_1_mouse_entered() -> void:
	if(abilities.size() > 0):
		show_description(abilities[0], costs[4])
		show_uses_left(abilities[0])

func _on_ability_2_mouse_entered() -> void:
	if(abilities.size() > 1):
		show_description(abilities[1], costs[5])
		show_uses_left(abilities[1])

# Units/abilities unhover signal
func _on_button_mouse_exited() -> void:
	$UnitDescription.hide()
	$UnitDescription/HBoxContainer/HBoxContainer2/UsesLeft.hide()
