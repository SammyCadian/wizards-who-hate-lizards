extends Control

@export var incomeTime = 5

var magicPoints

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ResourceTimer.wait_time = incomeTime/100
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_income_timer_timeout() -> void:
	if($IncomeVisual.value == 100):
		$IncomeVisual.value = 0
		magicPoints += 1
	
	$IncomeVisual.value += 1
	pass # Replace with function body.
