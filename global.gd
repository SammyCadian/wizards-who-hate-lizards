extends Node

# Global dictionary to track purchased shop items
var boughtItems = {
	"Missile Launch" : 0,
	"Flame Rain" : 0,
	"Anti-Dying Circle" : 0,
	"Shotgun" : 0
}

# Global array to track unlocked units
var unlockedUnits = []

# Global variable to track the player's reward from battle
var PLAYER_WAR_BONDS = 0

# Global variable to track game progress
var NODES_COMPLETED = 0

# Global variable to track the battles won
var BATTLES_WON = 0

# Global variables for getting God Scout
var SCOUT_DAMAGE = 2
var SCOUT_SPEED = 80
var SCOUT_HEALTH = 10

# Give the player GOD SCOUT
func GET_GOD_SCOUT():
	SCOUT_DAMAGE = 200
	SCOUT_SPEED = 1000
	SCOUT_HEALTH = 10000

# Add to player war bonds
func ADD_WAR_BONDS(amount: int):
	PLAYER_WAR_BONDS += amount

# Reset the player after losing
func resetPlayer():
	PLAYER_WAR_BONDS = 0
	BATTLES_WON = 0
	NODES_COMPLETED = 0
	unlockedUnits = []
	boughtItems["Missile Launch"] = 0
	boughtItems["Flame Rain"] = 0
	boughtItems["Anti-Dying Circle"] = 0
	boughtItems["Shotgun"] = 0

var damageMultiplier = 1
var healthUpgrade = 1

func setDamageUpgrade(moredamages):
	damageMultiplier += moredamages


func getDamageUpgrade():
	return damageMultiplier
	

func setHealthUpgrade(morehealths):
	healthUpgrade += morehealths
	
	
func getHealthUpgrade():
	return healthUpgrade
