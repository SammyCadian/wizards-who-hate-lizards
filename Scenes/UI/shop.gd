extends Control

# Preload nodes for instantation
var shopItemScene = preload("res://Scenes/UI/shop_item.tscn")

@export var selectedItem =  null # Track the currently selected item

# Store all possible shop items in an array
var shopItems = ["Missle", "Fireball Rain", "PLACEHOLDER3", "PLACEHOLDER4"]

func _ready() -> void:
	# Get each item properties and instantiate them in the shop
	for i in range(0, 4):
		# Get the items properties
		var itemName = shopItems[i]
		var itemMarker = get_node("item" + str(i + 1))
		var boughtFlag = Global.boughtItems.has(itemName)
		
		instShopItem(itemName, itemMarker, boughtFlag)
	
func instShopItem(name, itemMarker : Marker2D, boughtFlag : bool) -> Control:
	var shopItemInstance = shopItemScene.instantiate()
	shopItemInstance.name = name # Name the ability for future reference
	shopItemInstance.get_node("Name").text = name # Set the ability name
	shopItemInstance.get_node("Cost").text = "$100" # Set the ability name
	# shopItemInstance.get_node("Icon").texture = name # Set the icon based on the name
	
	shopItemInstance.get_node("Button").pressed.connect(_shop_item_selected) # Connect the pressed signal
	itemMarker.add_child(shopItemInstance) # Add it to the map
	
	# Enable the item if it wasn't bought already
	if !boughtFlag:
		shopItemInstance.enable()
	
	return shopItemInstance

# Signal connect for a shop item being pressed
func _shop_item_selected():
	$BuyButton.disabled = false

# Buy an item in the shop
func buyItem():
	# Buy the item if able
	if (Global.PLAYER_WAR_BONDS >= 100 && selectedItem != null):
		print(selectedItem.name + " purchased!")
		
		# Update player variables
		Global.PLAYER_WAR_BONDS -= 100
		Global.boughtItems.append(selectedItem.name)
		
		# Clear the item selection
		selectedItem.disable()
		$BuyButton.disabled = true
		selectedItem = null
		get_parent().updateWarBonds()
	else:
		print("Cannot buy " + selectedItem.name + "!")

func _on_map_button_pressed() -> void:
	get_parent().loadMap()

func _on_buy_button_pressed() -> void:
	buyItem()
