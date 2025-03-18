extends Node2D

# Preload a map node scene for instantiation
var mapNode = preload("res://Scenes/UI/map_node.tscn")

# Make an rng object for randomizing the map
var rng = RandomNumberGenerator.new()

# Define arrays with all possible random values
var battleArray = ["Tundra", "Mountains", "Beach", "City"]
var upgradeArray = ["Sale", "Health", "Damage", "Armor"]

func _ready() -> void:
	# The start, shop, and boss nodes are always the same
	instMapNode("Forest", "Battle", $node0)
	instMapNode("Shop", "Shop", $node3)
	instMapNode("Boss", "Boss", $node7)
	
	# Randomize the rest of the map
	randomizeMap()
	
func instMapNode(name, nodeType, mapMarker) -> void:
	var mapNodeInstance = mapNode.instantiate()
	mapNodeInstance.name = name # Name the node for future reference
	mapNodeInstance.get_node("Label").text = name # Label the node
	# mapNodeInstance.get_node("Icon").texture = # Set the node icon based on nodeType
	mapMarker.add_child(mapNodeInstance) # Add it to the map

# Randomize all of the battle nodes on the map
func randomizeBattles() -> void:
	var randomIndex = rng.randi_range(0, upgradeArray.size() - 1)
	instMapNode(upgradeArray.pop_at(randomIndex) + " Upgrade", "Upgrade", $topPathNode1)
	
	randomIndex = rng.randi_range(0, upgradeArray.size() - 1)
	instMapNode(upgradeArray.pop_at(randomIndex) + " Upgrade", "Upgrade", $bottomPathNode1)
	
	randomIndex = rng.randi_range(0, upgradeArray.size() - 1)
	instMapNode(upgradeArray.pop_at(randomIndex) + " Upgrade", "Upgrade", $node5)

# Randomize all of the upgrade nodes on the map
func randomizeUpgrades() -> void:
	var randomIndex = rng.randi_range(0, battleArray.size() - 1)
	instMapNode(battleArray.pop_at(randomIndex) + " Battle", "Battle", $topPathNode2)
	
	randomIndex = rng.randi_range(0, battleArray.size() - 1)
	instMapNode(battleArray.pop_at(randomIndex) + " Battle", "Battle", $bottomPathNode2)
	
	randomIndex = rng.randi_range(0, battleArray.size() - 1)
	instMapNode(battleArray.pop_at(randomIndex) + " Battle", "Battle", $node4)
	
	instMapNode(battleArray.pop_front() + " Battle", "Battle", $node6)

func randomizeMap() -> void:
	randomizeBattles()
	randomizeUpgrades()
	
