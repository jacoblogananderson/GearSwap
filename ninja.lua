--  Welcome to Logical's Ninja Lua.  This Lua is used for changing gear during precast and midcast and then swapping to the appropriate set for aftercast.
--  It will also cancel shadows for you when necessary to recast new shadows.
--  Thanks to Bulbafett on the NextGames Discord for helping me add the new Ninja Information section!
--  Please refer to my video on my NextGames YouTube channel for how to properly utilize this LUA.  

-- This is what sets the initial set that you normally want to be in by default.
tp_mode = 'dw0'
mb_mode = 'mbnin'

-- This is what sets up the Ninja Information Section.
shika = 0
inofu = 0
chono = 0
shihei = 0 
utsubuff = "\\cs(255,0,0)0"

gearswap_box = function()
  str = '           \\cs(130,130,130)NINJA\\cr\n'
  str = str..' Offense Mode:\\cs(255,150,100)   '..tp_mode..'\\cr\n'
  str = str..' Casting Mode:\\cs(255,150,100)   '..mb_mode..'\\cr\n'
  str = str..'  Ino(E): '..inofu..'\\cs(255,255,255)   Shika(B): '..shika..'\\cr\n'
  str = str..'Cho(D): '..chono.."\\cs(255,255,255)  Shihei(U): "..shihei.."\\cr\n"
  str = str..'Utsusemi Shadows: '..utsubuff.."\\cr\n"
  return str
end

-- This is what determines the starting location of the Ninja Information Section.
-- Update the X, Y positions to change where this box defaults. Once loaded the box is dragable. 
gearswap_box_config = {pos={x=20,y=240},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function user_setup()
	check_tool_count()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
end


function self_command(command)
	 local args = split_args(command)
		if args[1] == 'tp' then
		tp_mode = args[2]
	 elseif args[1] == 'mb' then
		mb_mode = args[2]
	 end
end
 
function split_args(args)
		fields = {}
		args:gsub("([^ ]*) ?", function(c)
		table.insert(fields, c)
	end)
	return fields
end

function get_sets()

-- This is where we will define our precast sets.  These are sets of gear that get equiped BEFORE the spell or ability is used.
	sets.precast = {}
	sets.precast.fc = {
		
	}
	
	sets.precast.utsusemi = {
		feet="Hattori Kyahan +1",
		back={ name="Andartia's Mantle", augments={'"Dbl.Atk."+10',}},
	}
	
-- This is where we will define our midcast sets.  These are sets of gear that get equiped BEFORE the spell or ability lands.
	sets.midcast = {}
	sets.midcast.enmity = {
		
	}

	sets.midcast.elenin = {
		hands="Hattori Tekko +1",
		legs="Iuitl Tights +1",
	}
	
	sets.midcast.mbnin = {
		hands="Hattori Tekko +1",
		legs="Iuitl Tights +1",
	}
	
	sets.midcast.futae = {
		
	}

	sets.midcast.enfnin = {
		
	}
	
	sets.midcast.waltz = {
		
	}

	sets.midcast.bladehi = {
		waist="Shadow Belt",
		neck="Shadow Gorget",
	}
	
	sets.midcast.blademetsu = {
		
	}
	
	sets.midcast.bladeshun = {
		waist="Thunder Belt",
		waist="Thunder Gorget",
	}
	
	sets.midcast.bladeten = {
		
	}
	
	sets.midcast.bladekamu = {
		waist="Shadow Belt",
	}

	sets.midcast.bladeku = {
		
	}

	sets.midcast.bladechi = {
		
	}
		
	sets.midcast.savageblade = {
		
	}

	sets.midcast.edge = {
		
	}

	sets.midcast.evis = {
		
	}

	sets.midcast.truestrike = {
		
	}

	sets.midcast.asuran = {
		
	}

-- This is where we will define our aftercast sets.  These are sets of gear that get equiped AFTER the spell or ability is used.  Normally this is used to put you back into your current TP set.
	sets.aftercast = {}
	sets.aftercast.dw40 = {
		ammo="Happo Shuriken",
		head="Hattori Zukin +1",
		body={ name="Mochi. Chainmail +1", augments={'Enhances "Sange" effect',}},
		hands="Ken. Tekko",
		legs={ name="Mochi. Hakama +1", augments={'Enhances "Mijin Gakure" effect',}},
		feet="Taeon Boots",
		neck="Ninja Nodowa",
		waist="Windbuffet Belt +1",
		left_ear="Suppanomimi",
		right_ear="Brutal Earring",
		left_ring="Epona's Ring",
		right_ring="Rajas Ring",
		back={ name="Andartia's Mantle", augments={'"Dbl.Atk."+10',}},
	}
	
	sets.aftercast.dw20 = {
		ammo="Happo Shuriken",
		head="Ken. Jinpachi",
		body={ name="Mochi. Chainmail +1", augments={'Enhances "Sange" effect',}},
		hands="Ken. Tekko",
		legs={ name="Mochi. Hakama +1", augments={'Enhances "Mijin Gakure" effect',}},
		feet="Ken. Sune-Ate",
		neck="Ninja Nodowa",
		waist="Windbuffet Belt +1",
		left_ear="Suppanomimi",
		right_ear="Brutal Earring",
		left_ring="Epona's Ring",
		right_ring="Rajas Ring",
		back={ name="Andartia's Mantle", augments={'"Dbl.Atk."+10',}},
	}

	sets.aftercast.dw0 = {
		ammo="Happo Shuriken",
		head="Ken. Jinpachi",
		body="Ken. Samue",
		hands="Ken. Tekko",
		legs="Ken. Hakama",
		feet="Ken. Sune-Ate",
		neck="Ninja Nodowa",
		waist="Windbuffet Belt +1",
		left_ear="Brutal Earring",
		right_ear={ name="Hattori Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+7','Mag. Acc.+7',}},
		left_ring="Epona's Ring",
		right_ring="Rajas Ring",
		back={ name="Andartia's Mantle", augments={'"Dbl.Atk."+10',}},
	}

	sets.aftercast.accuracy = {
		
	}

	sets.aftercast.evasion = {
		
	}
	
	sets.aftercast.magiceva = {
		
	}

	sets.aftercast.magicdef = {
		
	}
	
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

	if spell.english:startswith('Monomi') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Tonko') then
		equip(sets.precast.fc)
	end
	
	if spell.english:startswith('Gekka') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Yain') then
		equip(sets.precast.fc)
	end
	
	if spell.english:startswith('Kakka') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Myoshu') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Migawari') then
		equip(sets.precast.fc)
	end
	
	if spell.english:startswith('Yurin') then
		equip(sets.precast.fc)
	end
	
	if spell.english:startswith('Dokumori') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Aisha') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Kurayami') then
		equip(sets.precast.fc)
	end
	
	if spell.english:startswith('Hojo') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Jubaku') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Katon') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Hyoton') then
		equip(sets.precast.fc)
	end
	
	if spell.english:startswith('Huton') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Doton') then
		equip(sets.precast.fc)
	end

	if spell.english:startswith('Raiton') then
		equip(sets.precast.fc)
	end
	
	if spell.english:startswith('Suiton') then
		equip(sets.precast.fc)
	end
	
	if spell.type == "WhiteMagic" then
		equip(sets.precast.fc)
	end

	if spell.type == "BlackMagic" then
		equip(sets.precast.fc)
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

	if spell.english == "Provoke" then
		equip(sets.midcast.enmity)
	end

	if spell.english == "Warcry" then
		equip(sets.midcast.enmity)
	end

	if spell.english == "Animated Flourish" then
		equip(sets.midcast.enmity)
	end

	if spell.english == "Violent Flourish" then
		equip(sets.midcast.enfnin)
	end

	if spell.english:startswith('Curing') then
		equip(sets.midcast.waltz)
	end

	if spell.english == "Divine Waltz" then
		equip(sets.midcast.waltz)
	end
	
	if spell.english:startswith('Migawari') then
		equip(sets.midcast.migawari)
	end
	
	if spell.english:startswith('Kurayami') then
		equip(sets.midcast.enfnin)
	end

	if spell.english:startswith('Hojo') then
		equip(sets.midcast.enfnin)
	end

	if spell.english:startswith('Jubaku') then
		equip(sets.midcast.enfnin)
	end

	if spell.english:startswith('Aisha') then
		equip(sets.midcast.enfnin)
	end

	if spell.english:startswith('Yurin') then
		equip(sets.midcast.enfnin)
	end

	if spell.type == "WhiteMagic" then
		equip(sets.midcast.enfnin)
	end

	if spell.type == "BlackMagic" then
		equip(sets.midcast.enfnin)
	end

	if spell.english:startswith('Katon') then
		set = sets.midcast
		if set[mb_mode] then
			set = set[mb_mode]
		end
		equip(set)
	end

	if spell.english:startswith('Hyoton') then
		set = sets.midcast
		if set[mb_mode] then
			set = set[mb_mode]
		end
		equip(set)
	end

	if spell.english:startswith('Huton') then
		set = sets.midcast
		if set[mb_mode] then
			set = set[mb_mode]
		end
		equip(set)
	end

	if spell.english:startswith('Doton') then
		set = sets.midcast
		if set[mb_mode] then
			set = set[mb_mode]
		end
		equip(set)
	end

	if spell.english:startswith('Raiton') then
		set = sets.midcast
		if set[mb_mode] then
			set = set[mb_mode]
		end
		equip(set)
	end

	if spell.english:startswith('Suiton')then
		set = sets.midcast
		if set[mb_mode] then
			set = set[mb_mode]
		end
		equip(set)
	end
	
	if spell.english == "Blade: Hi" then
		equip(sets.midcast.bladehi)
	end

	if spell.english == "Blade: Metsu" then
		equip (sets.midcast.blademetsu)
	end

	if spell.english == "Blade: Shun" then
		equip (sets.midcast.bladeshun)
	end

	if spell.english == "Blade: Ten" then
		equip (sets.midcast.bladeten)
	end
	
	if spell.english == "Blade: Chi" then
		equip (sets.midcast.bladechi)
	end
	
	if spell.english == "Blade: To" then
		equip (sets.midcast.bladechi)
	end
	
	if spell.english == "Blade: Yu" then
		equip (sets.midcast.bladechi)
	end

	if spell.english == "Blade: Kamu" then
		equip (sets.midcast.bladechi)
	end

	if spell.english == "Blade: Ku" then
		equip (sets.midcast.bladeku)
	end

	if spell.english == "Blade: Teki" then
		equip (sets.midcast.bladechi)
	end

	if spell.english == "Blade: Retsu" then
		equip (sets.midcast.bladeten)
	end

	if spell.english == "Blade: Rin" then
		equip (sets.midcast.bladeten)
	end

	if spell.english == "Blade: Jin" then
		equip (sets.midcast.bladeten)
	end

	if spell.english == "Savage Blade" then
		equip (sets.midcast.savageblade)
	end

	if spell.english == "Aeolian Edge" then
		equip (sets.midcast.savageblade)
	end

	if spell.english == "Evisceration" then
		equip (sets.midcast.evis)
	end

	if spell.english == "True Strike" then
		equip (sets.midcast.truestrike)
	end

	if spell.english == "Asuran Fists" then
		equip (sets.midcast.asuran)
	end

	if spell.english == "Judgment" then
		equip (sets.midcast.truestrike)
	end

	if spell.english == "Tachi: Ageha" then
		equip (sets.midcast.enfnin)
	end

	if spell.english == "Tachi: Kasha" then
		equip (sets.midcast.savageblade)
	end

	if spell.english == "Tachi: Koki" then
		equip (sets.midcast.bladechi)
	end

	if spell.english == "Tachi: Jinpu" then
		equip (sets.midcast.bladeten)
	end

	if spell.english == "Tachi: Kagero" then
		equip (sets.midcast.bladechi)
	end

	if spell.english == "Tachi:Goten" then
		equip (sets.midcast.bladeten)
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
	ctool = {'Shikanofuda',
		'Shihei',
		'Chonofuda',
		'Inoshishinofuda'}

	for t =1,4  do

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
			shika = a
		elseif t == 2 then
			shihei = a
		elseif t == 3 then
			chono = a 
		elseif t == 4 then
			inofu = a 
		end
	end
end

user_setup()