extends Control

signal unitButtonPressed(pressedUnitID: String)

@export var incomeTime = 2.0 # Timer between getting more magic points
var magicPoints = 0 # Track the number of magic points, as displayed in the U.I


# Units in each button, global script should update these as the player unlocks/selects other units outside of battle
@export var unitOneIcon: CompressedTexture2D
@export var unitTwoIcon: CompressedTexture2D
@export var unitThreeIcon: CompressedTexture2D
# @export var unitFour = "FOURTH_UNIT"

#Holds IDs for units and abilities
var units = []
var abilities = []

#Load units in for testing purposes
func testLoad():
	receiveUnit(unitOneIcon, "scout")
	receiveUnit(unitTwoIcon, "rifleman")
	receiveUnit(unitThreeIcon, "autorifle")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	testLoad()
	
	$IncomeTimer.set_wait_time(incomeTime/100)
	$IncomeTimer.start()
	updatePoints()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updatePoints():
	$PointsLabel.text = str(magicPoints)

#Load a unit ID and button icon into the UI
func receiveUnit(icon: CompressedTexture2D, unitID: String):
	units.append(unitID)
	match units.size():
		1:
			$Units/Column1/UnitOne.icon = icon
			$Units/Column1/UnitOne.disabled = false
		2:
			$Units/Column1/UnitTwo.icon = icon
			$Units/Column1/UnitTwo.disabled = false
		3:
			$Units/Column2/UnitThree.icon = icon
			$Units/Column2/UnitThree.disabled = false
		4:
			$Units/Column2/UnitFour.icon = icon
			$Units/Column2/UnitFour.disabled = false
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
	if (magicPoints >= 10):
		magicPoints -= 10
		updatePoints()
		unitButtonPressed.emit(units[0])

func _on_unit_two_pressed() -> void:
	if (magicPoints >= 20):
		magicPoints -= 20
		updatePoints()
	unitButtonPressed.emit(units[1])

func _on_unit_three_pressed() -> void:
	if (magicPoints >= 40):
		magicPoints -= 40
		updatePoints()
	unitButtonPressed.emit(units[2])

func _on_unit_four_pressed() -> void:
	if (magicPoints >= 100):
		magicPoints -= 100
		updatePoints()
	unitButtonPressed.emit(units[3])
