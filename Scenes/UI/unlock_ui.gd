extends Control

# Dictionary of all unlockable unit names
var namesDict = {2 : "Rifleman", 3 : "AutoRifle", 4 : "Sniper", 5 : "Hoplite", 6 : "Caster"}

# Make an rng object for randomizing unlocked units
var rng = RandomNumberGenerator.new()

var pickedUnits = [] # Track the randomly picked units for unlocking
var selection = 0 # Track the unit selected

func _ready() -> void:
	if (Global.unlockedUnits.size() == 4):
		pickRandomUnits(1)
		selection = pickedUnits[0]
		Global.unlockedUnits.append(selection)
		setUnit(selection)
		
		$Option1.hide()
		$Option2.hide()
		$ChosenUnit.show()
		$Continue.show()
		$Label.text = "New Unit Unlocked!"
	else:
		pickRandomUnits(2)
		
		# Set the first option
		$Option1/UnitIcon.animation = str(pickedUnits[0])
		$Option1/UnitName.text = namesDict[pickedUnits[0]]
		
		# Set the second option
		$Option2/UnitIcon.animation = str(pickedUnits[1])
		$Option2/UnitName.text = namesDict[pickedUnits[1]]

func pickRandomUnits(amount : int):
	while (pickedUnits.size() < amount):
		var randomIndex = rng.randi_range(2,6)
		if (!Global.unlockedUnits.has(randomIndex) && !pickedUnits.has(randomIndex)):
			pickedUnits.append(randomIndex)

func _on_button_pressed() -> void:
	Global.unlockedUnits.append(selection)
	queue_free()

func _on_button_1_pressed() -> void:
	selection = pickedUnits[0]
	$Continue.show()

func _on_button_2_pressed() -> void:
	selection = pickedUnits[1]
	$Continue.show()

func setUnit(unitID : int):
	$ChosenUnit/UnitIcon.animation = str(unitID)
	$ChosenUnit/UnitName.text = namesDict[unitID]
