extends Control

@export var incomeTime = 5.0

var magicPoints = 0

#Holds IDs for units and abilities
var units = []
var abilities = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
