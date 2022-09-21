--  Welcome to Logical's Ninja Lua.  This Lua is used for changing gear during precast and midcast and then swapping to the appropriate set for aftercast.
--  It will also cancel shadows for you when necessary to recast new shadows.
--  Thanks to Bulbafett on the NextGames Discord for helping me add the new Ninja Information section!
--  Please refer to my video on my NextGames YouTube channel for how to properly utilize this LUA.  

-- This is what sets the initial set that you normally want to be in by default.
tp_mode = 'multiattack'

-- This is what sets up the Ninja Information Section.
sanja = 0
shino = 0
shihei = 0 
utsubuff = "\\cs(255,0,0)0"

gearswap_box = function()
  str = '                         \\cs(130,130,130)THIEF\\cr\n'
  str = str..'       Offense Mode:\\cs(255,150,100)   '..tp_mode..'\\cr\n'
  str = str..'       Sanja(B): '..sanja..'    Shino(D): '..shino..'\\cs(255,255,255)\\cr\n'
  str = str..'Shihei(U): '..shihei..'     Utsusemi Shadows: '..utsubuff.."\\cr\n"
  return str
end

-- This is what determines the starting location of the Ninja Information Section.
-- Update the X, Y positions to change where this box defaults. Once loaded the box is dragable. 
gearswap_box_config = {pos={x=20,y=240},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function get_sets()

	sets.precast = {}

-- This is where we will define our precast sets.  These are sets of gear that gets equipped BEFORE the spell or ability is used.
	sets.precast.utsusemi = {
		
	}
	
	sets.precast.SA = {
		
	}
	
	sets.precast.TA = {
		
	}
	
	sets.precast.despoil = {
	}
	
	sets.precast.flee = {
		
	}
	
	sets.precast.hide = {
		
	}
	
	sets.precast.assassinscharge = {
		
	}
	
	
-- This is where we will define our midcast sets.  These are sets of gear that gets equipped AFTER the spell or ability is used and BEFORE the spell or ability lands.
	sets.midcast = {}
	sets.midcast.enmity = {
		
	}
	
	sets.midcast.waltz = {
		
	}

	--DEX 50%
	sets.midcast.evisceration = {
	}

	--DEX 80%
	sets.midcast.rudrasstorm = {
	}

	--DEX 60%
	sets.midcast.mandalicstab = {
	}

	--DEX 40% / AGI 40%
	sets.midcast.sharkbite = {
	}

	--AGI 85%
	sets.midcast.exenterator = {
	}

	--DEX 40% / INT 40%
	sets.midcast.aeolianedge = {
	}

-- This is where we will define our aftercast sets.  These are sets of gear that get equiped AFTER the spell or ability is used.  Normally this is used to put you back into your current TP set.
	sets.aftercast = {}
	sets.aftercast.dw = {
		
	}
	
	sets.aftercast.evasionTH = {
	}
	
	sets.aftercast.evasion = {
		head="Turms Cap",
		body="Turms Harness",
		hands="Turms Mittens",
		legs="Turms Subligar",
		feet="Turms Leggings",
		neck="Evasion Torque",
		waist="Windbuffet Belt",
		left_ring="Warp Ring",
		right_ring="Resolution Ring",
	}

	sets.aftercast.multiattack = {
	}

	sets.aftercast.accuracy = {
		
	}
	
	sets.aftercast.magiceva = {
		
	}

	sets.aftercast.magicdef = {
		
	}
	
end

function equip_selected_set()
	--get_sets()
	set = sets.aftercast
	if set[tp_mode] then
		set = set[tp_mode]
	end
	equip(set)
end

function user_setup()
	--equip_selected_set()
	check_tool_count()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
end


function self_command(command)
	local args = split_args(command)
	if args[1] == 'tp' then
		tp_mode = args[2]
		equip_selected_set()gearswap_jobbox:text(gearswap_box())
		gearswap_jobbox:show()
	end
end
 
function split_args(args)
		fields = {}
		args:gsub("([^ ]*) ?", function(c)
		table.insert(fields, c)
	end)
	return fields
end

-----------------------------------------------------------------------------------
-- This is the precast section.  It is used for things you want to happen before you start to start to use the ability or spell.
 function precast(spell)

-- The below command is used to cancel old shadows if they can not be overwritten by the newly cased Utsusemi.
	if spell.english == "Utsusemi: Ichi" then
		if buffactive['Copy Image'] then
			send_command('cancel 66')
		elseif buffactive['Copy Image (2)'] then 
			send_command('cancel 444')
		elseif buffactive['Copy Image (3)'] then
			send_command('cancel 445')
		elseif buffactive['Copy Image (4+)'] then
			send_command('cancel 446')
		end
	end

	if spell.english == "Utsusemi: Ni" then
		if buffactive['Copy Image'] then
			send_command('cancel 66')
		elseif buffactive['Copy Image (2)'] then 
			send_command('cancel 444')
		elseif buffactive['Copy Image (3)'] then
			send_command('cancel 445')
		elseif buffactive['Copy Image (4+)'] then
			send_command('cancel 446')
		end
	end

	if spell.english:startswith('Utsusemi') then
		equip(sets.precast.utsusemi)
	end


	if spell.type == "Trust" then
		equip(sets.precast.fc)
	end
end

-----------------------------------------------------------------------------------
  -- This is the midcast section.  It is used to designate gear that you want on as the ability or spell is used.
function midcast(spell, act)

	if spell.english:startswith('Utsusemi') then
		equip(sets.precast.utsusemi)
	end
	
	if spell.english:startswith('Sneak Attack') then
		equip(sets.precast.SA)
	end
	
	if spell.english:startswith('Trick Attack') then
		equip(sets.precast.TA)
	end
	
	if spell.english:startswith('Despoil') then
		equip(sets.precast.despoil)
	end
	
	if spell.english:startswith('Flee') then
		equip(sets.precast.flee)
	end
	
	if spell.english:startswith('Hide') then
		equip(sets.precast.hide)
	end
	
	if spell.english:startswith("Assassin's Charge") then
		equip(sets.precast.assassinscharge)
	end


	if spell.english:startswith('Curing') then
		equip(sets.midcast.waltz)
	end

	if spell.english == "Divine Waltz" then
		equip(sets.midcast.waltz)
	end
	

	
	if spell.english == "Evisceration" then
		equip(sets.midcast.bladehi)
	end

	if spell.english == "Rudra's Storm" then
		equip (sets.midcast.blademetsu)
	end

	if spell.english == "Exenterator" then
		equip (sets.midcast.bladeshun)
	end

	if spell.english == "Aeolian Edge" then
		equip (sets.midcast.bladeten)
	end
	
	if spell.english == "Shark Bite" then
		equip (sets.midcast.bladechi)
	end

	if spell.type == "Trust" then
		equip(sets.precast.fc)
	end
end

-----------------------------------------------------------------------------------

-- This section is the aftercast section that makes it so that after any of the above abilities you get put back into the correct gearset.
-- You can create tp_mode gearsets for ANY purpose.  Just make sure you label them correctly.  All must be in the sets.aftercast section.  For instance sets.aftercast.dw40.
-- Don't forget to create a new gearset section defining the gear you want in it if you don't want to use my predefined sets.  Ie create a gearset for sets.aftercast.storetp.
function aftercast(spell, act, spellMap, eventArgs)
    set = sets.aftercast
	if set[tp_mode] then
		set = set[tp_mode]
	end
	equip(set)
	check_tool_count()
  --buff_change()
	gearswap_jobbox:text(gearswap_box())
	gearswap_jobbox:show()
end

-- The below commands are for controlling the Ninja Information Section.

function buff_change(buff, gain)
	if buffactive['Copy Image'] then
		utsubuff = "\\cs(255,127,0)1"	
	elseif buffactive['Copy Image (2)'] then 
		utsubuff = "\\cs(255,255,0)2"
	elseif buffactive['Copy Image (3)'] then
		utsubuff = "\\cs(127,255,0)3"
	elseif buffactive['Copy Image (4+)'] then
		utsubuff = "\\cs(0,255,0)4+"
	else 
		utsubuff = "\\cs(255,0,0)0" 
	end
	gearswap_jobbox:text(gearswap_box())
	gearswap_jobbox:show()
end	

function check_tool_count()
	ctool = {'Sanjaku-Tenugui',
		'Shihei',
		'Shinobi-Tabi'}

	for t =1,3  do

		if not player.inventory[ctool[t]] then
			curCount = 0
		elseif player.inventory[ctool[t]].count then
			curCount = player.inventory[ctool[t]].count
		end
		a = ''

		--defined green = 99
		cMax = 99
		cColorR = 0
		if curCount > cMax then
			cColorR = 0
			cColorG = 255
		else
			percent = (curCount/cMax * 100)
			if percent >=50 then
				cColorG = 255
				cColorR =math.floor(5 * (100-percent))
			else 
				cColorR = 255
				cColorG = 255-math.floor(5 * (50-percent))
			end
		end
		if curCount == 0 then
			a = "\\cs(255,0,0)" .. '0'
		else 
			a = "\\cs("..cColorR..","..cColorG..",0)" .. (curCount) 
		end

		if t == 1 then
			sanja = a
		elseif t == 2 then
			shihei = a
		elseif t == 3 then
			shino = a 
		end
	end
end

user_setup()