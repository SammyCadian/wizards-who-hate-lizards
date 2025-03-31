extends Node

# Global array to track purchased shop items
var boughtItems = []

# Global variable to track the player's reward from battle
var PLAYER_WAR_BONDS = 0

# Global variable to track game progress
var NODES_COMPLETED = 0

# Global variable to track completed battles
var BATTLES_WON = 0

# Add to player war bonds
func ADD_WAR_BONDS(amount: int):
	PLAYER_WAR_BONDS += amount
