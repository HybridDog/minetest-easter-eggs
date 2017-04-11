--chocolate egg config
HP_CHANGE = 3		--hp (or sp) healed with a single egg

--sugar rush effect config
SR_ENABLED = true
SR_DAMAGE = 2		--damage dealt to the player per second during sugar rush
SR_DURATION = 5		--duration of sugar rush effect in seconds
SR_SPEEDUP = 3		--speed multiplier of sugar rush effect (1 for normal speed)

MAX_SP = 20			--maximum value of sp(aka satiation, hunger); set this to appropriate value of the hunger mod you use
					--expected behaviour: player encounters sugar rush effect if and only if player's hunger bar is full before using the chocolate egg
					--supported hunger mods:
					--	https://github.com/BlockMen/hunger
					--	https://github.com/tenplus1/hudbars/tree/master/hbhunger		NOT TESTED
					--if this doesn't work correctly out of the box for you please add support for your hunger mod in get_sp() function

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
