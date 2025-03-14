extends Control

@export var incomeTime = 5.0

var magicPoints = 0

var battleNode = null # Parent battle node

# Units in each button, global script should update these as the player unlocks/selects other units outside of battle
@export var unitOne = "Unit"
# @export var unitTwo = "SECOND_UNIT"
# @export var unitThree = "THIRD_UNIT"
# @export var unitFour = "FOURTH_UNIT"

#Holds IDs for units and abilities
var units = []
var abilities = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	battleNode = get_parent() # Get the current battle
	
	$IncomeTimer.set_wait_time(incomeTime/100)
	$IncomeTimer.start()
	updatePoints()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_income_timer_timeout() -> void:
	if($IncomeVisual.value == 100):
		$IncomeVisual.value = 0
		magicPoints += 10
		updatePoints()
	
	$IncomeVisual.value += 1
	pass # Replace with function body.

func updatePoints():
	$PointsLabel.text = str(magicPoints)


func _on_unit_one_pressed() -> void:
	battleNode.unitSelected = true
	battleNode.unitName = unitOne
