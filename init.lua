dofile(minetest.get_modpath("easter_eggs") .. "/config.lua")
so_affected_players = {}

lp_index = {}
for i, _ in pairs(loot_pool) do
	table.insert(lp_index, i)
end

function sugar_overdose(player)
	local name = player:get_player_name()
	
	if so_affected_players[name] == nil then
		player:set_hp(player:get_hp() - SO_DAMAGE)
		player:set_physics_override({ speed = 1 })
		return
	end
	
	player:set_physics_override({ speed = SO_SPEEDUP })
	
	minetest.after(SO_DURATION, sugar_overdose, player)
	so_affected_players[name] = nil
end

function get_sp(player)			--get satiation points (hunger) of a player
	local name = player:get_player_name()
	
	if minetest.get_modpath("hud") and minetest.global_exists("hud") and hud.hunger then	--BlockMen's hud
		return tonumber(hud.hunger[name])
	elseif minetest.get_modpath("hunger") and minetest.global_exists("hunger") and hunger.players then		--BlockMen's hunger
		return hunger.players[name].lvl
	elseif minetest.get_modpath("hbhunger") then
		if minetest.global_exists("hbhunger") then
			if hbhunger.get_hunger then		--tenplus1's hbhunger
				return tonumber(hbhunger.get_hunger(player))
			elseif hbhunger.get_hunger_raw then			--Wuzzy's hbhunger
				return tonumber(hbhunger.get_hunger_raw(player))
			end
		elseif minetest.global_exists("hunger") and hunger.get_hunger then		--tenplus1's hbhunger legacy
			return tonumber(hunger.get_hunger(player))
		end
	end
	
	return 0
end

minetest.register_craftitem("easter_eggs:chocolate_egg", {
	description = "Chocolate egg",
	inventory_image = "easter_eggs_chocolate_egg.png",
	on_use = function(itemstack, player, pointed_thing)
		if SO_ENABLED and get_sp(player) >= MAX_SP then
			local name = player:get_player_name()
			
			if so_affected_players[name] == nil then
				minetest.after(1, sugar_overdose, player)
			end
			
			so_affected_players[name] = true
		end
			
		itemstack = minetest.do_item_eat(HP_CHANGE, nil, itemstack, player, pointed_thing)
		return itemstack
	end
})

minetest.register_node("easter_eggs:chocolate_block", {
	description = "Chocolate block",
	drawtype = "normal",
	tiles = { "easter_eggs_chocolate_block.png" },
	groups = { oddly_breakable_by_hand = 3 }
})

minetest.register_craft({
	output = "easter_eggs:chocolate_block",
	recipe = {
		{ "easter_eggs:chocolate_egg", "easter_eggs:chocolate_egg", "easter_eggs:chocolate_egg" },
		{ "easter_eggs:chocolate_egg", "easter_eggs:chocolate_egg", "easter_eggs:chocolate_egg" },
		{ "easter_eggs:chocolate_egg", "easter_eggs:chocolate_egg", "easter_eggs:chocolate_egg" }
	}
})

minetest.register_craft({
	output = "easter_eggs:chocolate_egg 9",
	recipe = {
		{ "easter_eggs:chocolate_block" }
	}
})

minetest.register_node("easter_eggs:gold_egg", {
	description = "Gold egg",
	drawtype = "mesh",
	mesh = "easter_eggs_gold_egg.obj",
	tiles = { "easter_eggs_gold.png" },
	groups = { oddly_breakable_by_hand = 3 },
	paramtype = "light",
	inventory_image = "easter_eggs_gold_egg.png",
	wield_image = "easter_eggs_gold_egg.png",
	on_use = function(itemstack, player, pointed_thing)
		local item
		minetest.do_item_eat(0, nil, itemstack, player, pointed_thing)
		
		for i = 0, math.random(LOOT_SIZE) do
			if itemstack:get_free_space() == 0 then
				break
			end
			
			item = lp_index[math.random(#lp_index)]
			player:get_inventory():add_item("main", item .. " " .. math.random(loot_pool[item]))
		end
		
		return itemstack
	end
})

minetest.register_craft({
	output = "default:goldblock",
	recipe = {
		{ "easter_eggs:gold_egg", "easter_eggs:gold_egg", "easter_eggs:gold_egg" },
		{ "easter_eggs:gold_egg", "easter_eggs:gold_egg", "easter_eggs:gold_egg" },
		{ "easter_eggs:gold_egg", "easter_eggs:gold_egg", "easter_eggs:gold_egg" }
	}
})
