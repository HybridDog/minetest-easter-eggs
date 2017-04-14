--chocolate egg config
HP_CHANGE = 3		--hp (or sp) healed with a single egg

--'sugar overdose' effect config
SO_ENABLED = true
SO_DAMAGE = 10		--damage dealt to the player due to 'sugar overdose'
SO_DURATION = 5		--duration of 'sugar overdose' speedup effect in seconds
SO_SPEEDUP = 3		--speed multiplier of 'sugar overdose' speedup effect (1 for normal speed)

MAX_SP = 20			--maximum value of sp(aka satiation, hunger)

--golden egg config
LOOT_SIZE = 4		--maximum number of different item types per egg
loot_pool = {}		--item string = maximum quantity
loot_pool["default:apple"]			= 15
loot_pool["default:cactus"]			= 4
loot_pool["default:clay_lump"]		= 8
loot_pool["default:coalblock"]		= 3
loot_pool["default:coral_orange"]	= 2
loot_pool["default:coral_brown"]	= 2
loot_pool["default:coral_skeleton"]	= 3
loot_pool["default:iron_lump"]		= 8
loot_pool["default:copper_lump"]	= 8
loot_pool["default:gold_lump"]		= 5
loot_pool["default:mese_crystal"]	= 3
loot_pool["default:diamond"]		= 3

loot_pool["default:axe_bronze"]		= 1
loot_pool["default:axe_mese"]		= 1
loot_pool["default:axe_diamond"]	= 1
loot_pool["default:pick_bronze"]	= 1
loot_pool["default:pick_mese"]	= 1
loot_pool["default:pick_diamond"]= 1
loot_pool["default:shovel_bronze"]	= 1
loot_pool["default:shovel_mese"]	= 1
loot_pool["default:shovel_diamond"]	= 1

loot_pool["default:sapling"]		= 3
loot_pool["default:acacia_sapling"]	= 2
loot_pool["default:aspen_sapling"]	= 2
loot_pool["default:junglesapling"]	= 2
loot_pool["default:pine_sapling"]	= 2

loot_pool["default:sand"]			= 5
loot_pool["default:desert_sand"]	= 5
loot_pool["default:silver_sand"]	= 5

--eggs spawn config
ES_ENABLED = true
ES_DENSITY = 20		--number of eggs dropped around player
ES_RADIUS = 50		--area around the player where the eggs drop
					--please note that statistically most eggs will spawn near ES_RADIUS/2 nodes away from player
