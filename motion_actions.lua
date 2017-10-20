return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			25,81,83,107,116,153,85
		},
	},

	execute = function(domoticz, device)
		debug = true
		local Eetkamerdeur = domoticz.devices(25)
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
		local lamp_hal_boven = domoticz.devices(151)
		local dimmer_bed_martijn = domoticz.devices(149)		
		local dimmer_bed_suzanne = domoticz.devices(150)
		local IsDark = domoticz.devices(78)
		local Time = require('Time')
		if IsDark == 'On' then
			if (domoticz.time.matchesRule('at 16:00-01:00') and PIR_woonk.state == 'On') then
				-- between 16:00 and 1:00 then next day
				if (lampen_woonkamer.state == 'Off') then
					lampen_woonkamer.switchOn
					domoticz.log('Beweging woonkamer terwijl het donker is -> lampen woonkamer aangezet')
				end
			elseif (domoticz.time.matchesRule('at 01:00-16:00') and PIR_woonk.state == 'On') then
				domoticz.log('Beweging nachts in de woonkamer!')		
			end
			if (PIR_halboven.state == 'On') then
				if (lamp_hal_boven.state == 'Off') then
					lamp_hal_boven.switchOn
					domoticz.log('Beweging hal boven terwijl het donker is -> lamp hal boven aangezet')
				end
			end
		else
			if debug then print('No action because it is not dark') end
		end
	end
}
