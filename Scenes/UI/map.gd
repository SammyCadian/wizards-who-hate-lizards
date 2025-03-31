extends Node2D

# Preload nodes for instantation
var mapNodeScene = preload("res://Scenes/UI/map_node.tscn")
var unitSelectScene = preload("res://Scenes/UI/unit_selection.tscn")

@export var selectedMapNode =  null # Track the currently selected node
var currUnitSelect =  null # Track the currently selected node
var mapNodeArray = [] # Store all map nodes in an array

# Make an rng object for randomizing the map
var rng = RandomNumberGenerator.new()

# Define arrays with all possible random values
var battleArray = ["Tundra", "Mountains", "Beach", "City"]
var upgradeArray = ["Sale", "Health", "Damage", "Armor"]

func _ready() -> void:
	# The start, shop, and boss nodes are always the same
	instMapNode("Forest", "Battle", $node0).enable() # The first node starts enabled
	instMapNode("Shop", "Shop", $node3)
	instMapNode("Boss", "Boss", $node7)
	
	# Randomize the rest of the map
	randomizeMap()
	
func instMapNode(name, nodeType, mapMarker) -> Control:
	var mapNodeInstance = mapNodeScene.instantiate()
	mapNodeInstance.name = name # Name the node for future reference
	mapNodeInstance.nodeType = nodeType # Set the node type
	mapNodeInstance.get_node("Label").text = name # Label the node
	
	# Set the node icon based on nodeType
	mapNodeInstance.get_node("Icon").animation = nodeType.to_lower()
	
	mapNodeInstance.get_node("Button").pressed.connect(_map_node_selected) # Connect the pressed signal
	mapNodeArray.append(mapNodeInstance) # Add it to the array
	mapMarker.add_child(mapNodeInstance) # Add it to the map
	
	return mapNodeInstance

# Randomize all of the upgrade nodes on the map
func randomizeUpgrades() -> void:
	var randomIndex = rng.randi_range(0, upgradeArray.size() - 1)
	var nodeType = "Upgrade"
	instMapNode(upgradeArray.pop_at(randomIndex) + " Upgrade", nodeType, $topPathNode1)
	
	randomIndex = rng.randi_range(0, upgradeArray.size() - 1)
	instMapNode(upgradeArray.pop_at(randomIndex) + " Upgrade", nodeType, $bottomPathNode1)
	
	randomIndex = rng.randi_range(0, upgradeArray.size() - 1)
	instMapNode(upgradeArray.pop_at(randomIndex) + " Upgrade", nodeType, $node5)

# Randomize all of the battle nodes on the map
func randomizeBattles() -> void:
	var randomIndex = rng.randi_range(0, battleArray.size() - 1)
	var nodeType = "Battle"
	instMapNode(battleArray.pop_at(randomIndex) + " Battle", nodeType, $topPathNode2)
	
	randomIndex = rng.randi_range(0, battleArray.size() - 1)
	instMapNode(battleArray.pop_at(randomIndex) + " Battle", nodeType, $bottomPathNode2)
	
	randomIndex = rng.randi_range(0, battleArray.size() - 1)
	instMapNode(battleArray.pop_at(randomIndex) + " Battle", nodeType, $node4)
	
	instMapNode(battleArray.pop_front() + " Battle", nodeType, $node6)

# Call the randomization functions
func randomizeMap() -> void:
	randomizeBattles()
	randomizeUpgrades()

# Connected from the unit selection signal, load into battle with the selected units
func loadBattle():
	var unitSelect = get_node("unitSelect")
	print(unitSelect.getUnits())
	get_parent().get_node("BattleManager").startBattle(unitSelect.getUnits())
	unitSelect.queue_free() # Free the unit selection

# Signal connect for a map node being pressed
func _map_node_selected():
	# Reset the unit select if needed
	if currUnitSelect != null:
		currUnitSelect.queue_free()
	
	# Display the unit select for battles
	if selectedMapNode.nodeType == "Battle":
		handleBattleSelect()

# Called when a selected node is a battle
func handleBattleSelect():
	selectedMapNode.get_node("Icon").frame = 1
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout # TODO find out why timer breaks unit select :(
	get_tree().paused = false
	currUnitSelect = unitSelectScene.instantiate()
	currUnitSelect.name = "unitSelect" # Rename it in the tree
	currUnitSelect.loadBattle.connect(loadBattle) # Connect the startGame signal
	add_child(currUnitSelect)
