extends Control

# Preload nodes for instantation
var shopItemScene = preload("res://Scenes/UI/shop_item.tscn")

@export var selectedItem =  null # Track the currently selected item

# Store all possible shop items in an array
var shopItems = ["Missile Launch", "Flame Rain", "Anti-Dying Circle", "Shotgun"]
var itemCosts = [100, 50, 100, 150]

# Ability Descriptions
var abilityDescriptions = ["KABOOM the lizards where you click! Works in adjacent lanes",
					"Summon a rain of fireballs to destroy your enemies!",
					"Manifest a big ol' anti death circle! note: does not prevent injury",
					"Summon a big boom stick to send your enemies to their god(s)"]

func _ready() -> void:
	# Get each item properties and instantiate them in the shop
	for i in range(0, 4):
		# Get the items properties
		var itemName = shopItems[i]
		var itemMarker = get_node("item" + str(i + 1))
		
		instShopItem(itemName, itemMarker, itemCosts[i])
	
func instShopItem(name, itemMarker : Marker2D, cost) -> Control:
	var shopItemInstance = shopItemScene.instantiate()
	shopItemInstance.name = name # Name the ability for future reference
	shopItemInstance.cost = cost # Set the item cost
	shopItemInstance.get_node("Cost").text = "$" + str(cost) # Set the ability name
	shopItemInstance.get_node("Icon").animation = name # Set the icon based on the name
	
	shopItemInstance.get_node("Button").pressed.connect(_shop_item_selected) # Connect the pressed signal
	shopItemInstance.get_node("Button").mouse_entered.connect(_mouse_entered) # Connect the mouse_entered signal
	shopItemInstance.get_node("Button").mouse_exited.connect(_mouse_exited) # Connect the mouse_exited signal
	itemMarker.add_child(shopItemInstance) # Add it to the shop
	
	return shopItemInstance

# Signal connect for a shop item being pressed
func _shop_item_selected():
	$BuyButton.disabled = false

# Buy an item in the shop
func buyItem():
	# Buy the item if able
	if (Global.PLAYER_WAR_BONDS >= selectedItem.cost && selectedItem != null):
		print(selectedItem.name + " purchased!")
		
		# Update player variables
		Global.PLAYER_WAR_BONDS -= selectedItem.cost
		Global.boughtItems[selectedItem.name] += 1
		get_parent().updateWarBonds()
		$BuyItemSound.play()
	else:
		print("Cannot buy " + selectedItem.name + "!")
		$CantBuyLabel.show()
		$CantBuySound.play()
		# Hide the Cannot Buy label after 1 second
		await get_tree().create_timer(1.0).timeout
		$CantBuyLabel.hide()

func _on_map_button_pressed() -> void:
	# Track the progress on the map
	Global.NODES_COMPLETED += 1
	get_parent().getmap().progressMap()
	
	# Load the map
	get_parent().loadMap()

# Mouse position tomfoolery to get the correct descriptions
func _mouse_entered() -> void:
	var mousePos = get_local_mouse_position()
	if (mousePos.distance_to($item1.position) < mousePos.distance_to($item2.position)):
		if (mousePos.distance_to($item1.position) < mousePos.distance_to($item3.position)):
			$Description.text = abilityDescriptions[0]
			$ItemName.text = shopItems[0]
			$Amount.text = "(You Have: " + str(Global.boughtItems[shopItems[0]]) + ")"
		else:
			$Description.text = abilityDescriptions[2]
			$ItemName.text = shopItems[2]
			$Amount.text = "(You Have: " + str(Global.boughtItems[shopItems[2]]) + ")"
	else:
		if (mousePos.distance_to($item2.position) < mousePos.distance_to($item4.position)):
			$Description.text = abilityDescriptions[1]
			$ItemName.text = shopItems[1]
			$Amount.text = "(You Have: " + str(Global.boughtItems[shopItems[1]]) + ")"
		else:
			$Description.text = abilityDescriptions[3]
			$ItemName.text = shopItems[3]
			$Amount.text = "(You Have: " + str(Global.boughtItems[shopItems[3]]) + ")"
		
	$Description.show()
	$ItemName.show()
	$Amount.show()
	
func _mouse_exited() -> void:
	$Description.hide()
	$ItemName.hide()
	$Amount.hide()

func _on_buy_button_pressed() -> void:
	buyItem()
