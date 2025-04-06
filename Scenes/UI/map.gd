extends Node2D

# Preload nodes for instantation
var mapNodeScene = preload("res://Scenes/UI/map_node.tscn")
var unitSelectScene = preload("res://Scenes/UI/unit_selection.tscn")

@export var selectedMapNode =  null # Track the currently selected node
var currUnitSelect =  null # Track the currently selected node
var mapNodeArray = [] # Store all map nodes in an array

# Make an rng object for randomizing the map
var rng = RandomNumberGenerator.new()

# Dictionary for each battle name and node pair
@onready var battleDict = {"Magnolia" : $magnoliaNode, "Barn" : $barnNode, "Mountain" : $mountainNode, 
"Beach" : $beachNode, "Forest1" : $forestNode, "Forest2" : $forestNode2, "Rock" : $rockNode, 
"Pond" : $pondNode, "Plains" : $plainsNode, "Boss" : $bossNode}

func _ready() -> void:	
	# Add the starting battle
	instMapNode("Barn", "Battle", battleDict["Barn"]).enable()
	mapNodeArray[0].show()
	
	# Randomize the map
	randomizeMap()
	
	# Add the shops and boss to the node map and array
	mapNodeArray.insert(2, instMapNode("Shop", "Shop", $shopNode1))
	mapNodeArray.insert(4, instMapNode("Shop", "Shop", $shopNode2))
	mapNodeArray.insert(7, instMapNode("Shop", "Shop", $shopNode3))
	mapNodeArray.append(instMapNode("???", "Boss", battleDict["Boss"]))
	
func instMapNode(name, nodeType, mapMarker) -> Control:
	var mapNodeInstance = mapNodeScene.instantiate()
	mapNodeInstance.name = name # Name the node for future reference
	mapNodeInstance.nodeType = nodeType # Set the node type
	mapNodeInstance.get_node("Label").text = name # Label the node
	mapNodeInstance.get_node("Icon").animation = nodeType.to_lower() # Set the node icon based on nodeType
	mapNodeInstance.get_node("Button").pressed.connect(_map_node_selected) # Connect the pressed signal
	
	if (nodeType == "Battle"):
		mapNodeArray.append(mapNodeInstance) # Add it to the array
	mapMarker.add_child(mapNodeInstance) # Add it to the map
	
	return mapNodeInstance

# Randomize all of the battle nodes on the map
func randomizeBattles() -> void:
	var randomIndex = rng.randi_range(0, 1)
	var nodeType = "Battle"
	
	# Randomize all battle pairs
	if (randomIndex == 1):
		instMapNode("Magnolia", nodeType, battleDict["Magnolia"])
	else:
		instMapNode("Forest", nodeType, battleDict["Forest1"])
	
	randomIndex = rng.randi_range(0, 1)
	if (randomIndex == 1):
		instMapNode("They're in the trees!", nodeType, battleDict["Forest2"])
	else:
		instMapNode("Mountain", nodeType, battleDict["Mountain"])
	
	randomIndex = rng.randi_range(0, 1)
	if (randomIndex == 1):
		instMapNode("Rock", nodeType, battleDict["Rock"])
	else:
		instMapNode("Beach", nodeType, battleDict["Beach"])
	
	randomIndex = rng.randi_range(0, 1)
	if (randomIndex == 1):
		instMapNode("Plains", nodeType, battleDict["Plains"])
	else:
		instMapNode("Pond", nodeType, battleDict["Pond"])

# Call the randomization functions
func randomizeMap() -> void:
	randomizeBattles()

# Connected from the unit selection signal, load into battle with the selected units
func loadBattle():
	print(currUnitSelect.getUnits())
	get_parent().get_node("BattleManager").startBattle(currUnitSelect.getUnits(), selectedMapNode.name)
	currUnitSelect.queue_free() # Free the unit selection

# Signal connect for a map node being pressed
func _map_node_selected():
	# Reset the unit select if needed
	if currUnitSelect != null:
		currUnitSelect.queue_free()
	
	# Display the unit select for battles
	if selectedMapNode.nodeType == "Battle":
		handleBattleSelect()
		
	# Switch into the shop
	if selectedMapNode.nodeType == "Shop":
		handleShopSelect()
		
	if selectedMapNode.nodeType == "Boss":
		handleBossSelect()

func handleBossSelect():
	currUnitSelect = unitSelectScene.instantiate()
	currUnitSelect.loadBattle.connect(loadBattle) # Connect the startGame signal
	add_child(currUnitSelect)
	
# Called when a selected node is a battle
func handleBattleSelect():
	selectedMapNode.get_node("Icon").frame = 1
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout # TODO find out why timer breaks unit select :(
	get_tree().paused = false
	currUnitSelect = unitSelectScene.instantiate()
	currUnitSelect.loadBattle.connect(loadBattle) # Connect the startGame signal
	add_child(currUnitSelect)

# Called when a selected node is a shop
func handleShopSelect():
	get_parent().loadScene("res://Scenes/UI/shop.tscn")
	get_parent().showWarBonds()

# After a node is visited, the next one is made available
func progressMap():
	# Update the battle node icons to reflect difficulty
	if (Global.BATTLES_WON == 2):
		for mapNode in mapNodeArray:
			if (mapNode.nodeType == "Battle" && !mapNode.is_visible()):
				mapNode.get_node("Icon").animation = "medium"
	if (Global.BATTLES_WON == 4):
		mapNodeArray[mapNodeArray.size() - 3].get_node("Icon").animation = "hard"
	
	# Disable the visited node and show the next one
	mapNodeArray[Global.NODES_COMPLETED - 1].disable()
	mapNodeArray[Global.NODES_COMPLETED].show()
	mapNodeArray[Global.NODES_COMPLETED].enable()
