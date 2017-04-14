dofile(minetest.get_modpath("easter_eggs") .. "/config.lua")
so_affected_players = {}

lp_index = {}
for i, _ in pairs(loot_pool) do
	table.insert(lp_index, i)
end

function sugar_overdose(player)
	local name = player:get_player_name()
	
	if so_affected_players[name] == nil then
		player:set_physics_override({ speed = 1 })
		return
	end
	
	player:set_physics_override({ speed = SO_SPEEDUP })
	minetest.after(1, sugar_overdose, player)
	so_affected_players[name] = so_affected_players[name] - 1
	
	if so_affected_players[name] < 1 then
		so_affected_players[name] = nil
	end
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
			
			so_affected_players[name] = SO_DURATION
			
			minetest.after(SO_DURATION, function(player)
				player:set_hp(player:get_hp() - SO_DAMAGE)
			end, player)
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

local item_entity_ttl = tonumber(core.setting_get("item_entity_ttl"))
if item_entity_ttl == nil then
	item_entity_ttl = 900
end

function easter_eggs_spawn()
	local item, pos, pos_r, pos_phi
	local SQRT_5 = math.sqrt(5)
	local f
	
	for _, player in ipairs(minetest.get_connected_players()) do
		item = "easter_eggs:" .. (math.random(100) == 1 and "gold_egg" or "chocolate_egg")
		
		pos = player:getpos()
		pos_r = math.random()												-- 0 <= pos_r <= 1
		pos_r = (4 * pos_r ^ 3 - 6 * pos_r ^ 2 + 3 * pos_r) * ES_RADIUS		-- pos_r := f(pos_r) = 4 * pos_r ^ 3 - 6 * pos_r ^ 2 + 3 * pos_r
																			-- f'(x) = 12x^2 - 12x + 3 > 0 => f monotonically increases		(0 <= x <= 1)
																			-- f(0) = 0		f(1) = 1
																			-- f: <0, 1> -> <0, 1>
																			-- f''(x) = 24x - 12 = 0 <=> x = 1/2
																			-- f is concave over <0, 1/2> and convex over <1/2, 1>
																			-- this means f is 'getting closer to be constant' the closer to 1/2 x is	(0 <= x <= 1)
																			-- thus statistically more items should generate halfway between player and the end of the area
		pos_phi = math.random() * 2 * math.pi
		pos.x = pos.x + pos_r * math.cos(pos_phi)
		pos.y = pos.y + 10
		pos.z = pos.z + pos_r * math.sin(pos_phi)
		minetest.spawn_item(pos, item)
	end
	
	if item_entity_ttl ~= -1 then
		minetest.after(item_entity_ttl, easter_eggs_spawn)
	end
end

if ES_ENABLED then
	for i = 1, ES_DENSITY do
		minetest.after(math.random() * item_entity_ttl, easter_eggs_spawn)
	end
end
