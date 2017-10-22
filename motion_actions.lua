return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			25,81,83,107,116,153,85,105,23,66,119
		},
	},

	execute = function(domoticz, device)
		debug = true
		local Eetkamerdeur = domoticz.devices(25)
		local Garagedeur = domoticz.devices(105)
		local Dakraamslaapk = domoticz.devices(81)
		local Balkondeurslaapk = domoticz.devices(83)
		local Voordeur = domoticz.devices(107)
		local BalkondeurNienke = domoticz.devices(116)
		local Slaapkdeur = domoticz.devices(153)
		local Dakraamzolder = domoticz.devices(85)
		local PIR_woonk = domoticz.devices(23)		
		local PIR_kamerLars = domoticz.devices(66)
		local PIR_halboven = domoticz.devices(119)
		local lampen_woonkamer = domoticz.groups(1)
		local buitenlampen = domoticz.groups(2)
		local lamp_hal_boven = domoticz.devices(151)
		local dimmer_bed_martijn = domoticz.devices(149)		
		local dimmer_bed_suzanne = domoticz.devices(150)
		local IsDark = domoticz.devices(78)
		local SomeoneHome = domoticz.devices(96)
		local Time = require('Time')
		--domoticz.log('IsDark.state = ' ..IsDark.state)
		if IsDark.state == 'On' then			
			if (domoticz.time.matchesRule('at 16:00-01:00') and PIR_woonk.state == 'On') then
				-- woonkamer aan avonds + donker
				-- between 16:00 and 1:00 then next day
				if (lampen_woonkamer.state == 'Off') then
					lampen_woonkamer.switchOn()
					domoticz.log('Beweging woonkamer terwijl het donker is, lampen woonkamer aangezet')
				end
			elseif (domoticz.time.matchesRule('at 01:00-16:00') and PIR_woonk.state == 'On') then
				-- woonkamer nachts + donker
				domoticz.log('Beweging nachts in de woonkamer!')		
			end
			if (PIR_halboven.state == 'On') then
				-- hal aan donker
				if (lamp_hal_boven.state == 'Off') then
					lamp_hal_boven.switchOn()
					domoticz.log('Beweging hal boven terwijl het donker is, lamp hal boven aangezet')
				end
			end
			if (domoticz.time.matchesRule('at 17:00-00:30') and Slaapkdeur.state == 'Open') then
				-- dimmers slaapkamer aan donker tot 0:30
				-- between 17:00 and 0:30 then next day
				if (dimmer_bed_martijn.state == 'Off') then
					dimmer_bed_martijn.switchSelector(6)
					domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Martijn aangezet')
				end
				if (dimmer_bed_suzanne.state == 'Off') then
					dimmer_bed_suzanne.switchSelector(6)
					domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Suzanne aangezet')
				end
			end
			if (SomeoneHome.state == 'Off') then
				-- woonkamer aan donker + deur open
				if (Eetkamerdeur.state == 'Open' or Voordeur.state == 'Open') then
					if (lampen_woonkamer.state == 'Off') then
						lampen_woonkamer.switchOn()
						domoticz.log('Eetkamerdeur of voordeur open terwijl het donker is, lampen woonkamer aangezet')
					end
				end
			end			
			if (Garagedeur.state == 'Open') then
				-- buitenlampen aan donker + garage deur open
				if (buitenlampen.state == 'Off') then
					buitenlampen.switchOn()
					domoticz.log('Garagedeur open terwijl het donker is, buitenlampen aangezet')
				end
			end
		else
			if debug then print('No action because it is not dark') end
		end
	end
}
