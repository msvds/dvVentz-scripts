return {
	active = true, -- set to false to disable this script
	on = {
		devices = {'Eetkamerdeur','Dakraam slaapkamer','Balkondeur slaapkamer','Front door','Balkondeur Nienke','Slaapkamerdeur','Deur bijkeuken','Zolderdakraam achter','Garage deur','Beweging woonkamer','Beweging kamer Lars','Beweging hal boven','Dimmer bed Martijn','Dimmer bed Suzanne','Lamp hal boven','Schemerlamp deur','Lamp spoelb keuken'},
	},

	execute = function(domoticz, device)
		debug = true
		local IsDark = domoticz.devices(78)
		local SomeoneHome = domoticz.devices(96)
		local Time = require('Time')
		--domoticz.log('IsDark.state = ' ..IsDark.state)
		if IsDark.state == 'On' then			
			if (domoticz.time.matchesRule('between sunset and 01:00') and domoticz.devices('Beweging woonkamer').state == 'On' and domoticz.devices('Sw1_woonkamerdeur').lastUpdate.minutesAgo > 3 and domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 3 and domoticz.devices('Sw4_eetkamerdeur').lastUpdate.minutesAgo > 3 and IsDark.state == 'On') then
				-- woonkamer aan avonds + donker
				-- between 16:00 and 1:00 then next day
				domoticz.helpers.switch_lights(domoticz,'Woonkamer','On')
			elseif (domoticz.time.matchesRule('between 15 minutes before sunset and sunset') and domoticz.devices('Beweging woonkamer').state == 'On' and domoticz.devices('Sw1_woonkamerdeur').lastUpdate.minutesAgo > 3 and domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 3 and domoticz.devices('Sw4_eetkamerdeur').lastUpdate.minutesAgo > 3 and IsDark.state == 'On') then
				-- woonkamer aan avonds + bijna donker
				domoticz.helpers.switch_lights(domoticz,'Eetkamer','On')
				domoticz.devices('Schemerlamp deur').switchOn().checkFirst()
				domoticz.devices('Lamp spoelb keuken').switchOn().checkFirst()				
			elseif (domoticz.time.matchesRule('between 06:00 and sunrise') and domoticz.devices('Beweging woonkamer').state == 'On' and domoticz.devices('Sw1_woonkamerdeur').lastUpdate.minutesAgo > 3 and domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 3 and domoticz.devices('Sw4_eetkamerdeur').lastUpdate.minutesAgo > 3 and IsDark.state == 'On') then
				-- woonkamer ochtends + donker
				domoticz.helpers.switch_lights(domoticz,'Keuken','On')
				domoticz.helpers.switch_lights(domoticz,'Eetkamer','On')
			elseif (domoticz.time.matchesRule('at 01:00-06:00') and domoticz.devices('Beweging woonkamer').state == 'On'  and IsDark.state == 'On') then
				-- woonkamer nachts + donker
				domoticz.helpers.switch_lights(domoticz,'Woonkamer','On')
				domoticz.log('Beweging nachts in de woonkamer!')			
			end
			if (domoticz.devices('Beweging hal boven').state == 'On' and domoticz.devices('Lamp hal boven').lastUpdate.minutesAgo > 5 and domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 5 and IsDark.state == 'On') then
				-- hal aan donker
				-- vertraging zodat als Sw3_bed is ingedrukt, niet meteen de lamp in de hal weer aangaat omdat de bewegingsensor nog op On staat
				if (domoticz.devices('Single Wall Switch Lampen Hal Boven Knop Beneden').lastUpdate.minutesAgo > 3 and domoticz.devices('Single Wall Switch Hal Boven').lastUpdate.minutesAgo > 3) then
					domoticz.helpers.switch_lights(domoticz,'HalBoven','On')
				end
			end
			if (device.name == domoticz.devices('Slaapkamerdeur').name and domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 3 and domoticz.time.matchesRule('at 17:00-21:30') and domoticz.devices('Slaapkamerdeur').state == 'Open' and IsDark.state == 'On') then
				-- dimmers slaapkamer aan donker tot 0:30
				-- between 17:00 and 21:30
				if (domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 3) and domoticz.devices('Dual Wall Switch Slaapkamer').lastUpdate.minutesAgo > 3 then
					domoticz.helpers.switch_lights(domoticz,'Slaapkamer','On')
				end
			elseif (device.name == domoticz.devices('Slaapkamerdeur').name and domoticz.time.matchesRule('at 21:30-23:30') and domoticz.devices('Slaapkamerdeur').state == 'Open' and domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 3 and IsDark.state == 'On') then
				-- dimmers slaapkamer aan donker tot 23:00
				-- between 21:30 and 23:00
				-- dimmer = 8
				if (domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 3 and domoticz.devices('Dual Wall Switch Slaapkamer').lastUpdate.minutesAgo > 3) then
					domoticz.helpers.switch_lights(domoticz,'Slaapkamer','On')
				end
				--domoticz.devices('Dimmer bed Martijn').dimTo(8)
				--domoticz.devices('Dimmer bed Suzanne').dimTo(8)
			end
			-- woonkamer aan donker + deur open
			if (domoticz.devices('Eetkamerdeur').state == 'Open' or domoticz.devices('Front door').state == 'Open') then
				domoticz.log('Eetkamerdeur of voordeur open bij thuiskomst terwijl het donker is, lampen woonkamer aangezet', domoticz.LOG_INFO)
				domoticz.helpers.switch_lights(domoticz,'Woonkamer','On')
			end		
			if (domoticz.devices('Garage deur').state == 'Open') then
				-- buitenlampen aan donker + garage deur open
				domoticz.log('Garagedeur open terwijl het donker is, buitenlampen aangezet', domoticz.LOG_INFO)
				domoticz.helpers.switch_lights(domoticz,'Achtertuin','On')
			end
		end
		if (domoticz.time.matchesRule('at 0:30-06:00') and domoticz.devices('Beweging garage').state == 'On') then
			-- TODO: write function to flash the lights
			-- garage aan nachts
			-- between 00:30 and 6:00			
			--domoticz.groups('Lampen woonkamer').switchOn().forSec(1).repeatAfterSec(1, 150)
			--domoticz.groups('Lampen woonkamer').switchOn().afterSec(300)
			--domoticz.groups('Buitenlampen').switchOn().forSec(1).repeatAfterSec(1, 150)
			--domoticz.groups('Buitenlampen').switchOn().afterSec(300)
			--domoticz.notify('Beweging garage terwijl het donker is, inbreker?', domoticz.PRIORITY_HIGH)
		end
		
		--verwarming
		if (domoticz.devices('Beweging kamer Lars').state == 'On') then
			domoticz.log('MC_PIR_kamerLars = ' ..domoticz.globalData.MC_PIR_kamerLars)
			if (domoticz.globalData.MC_PIR_kamerLars > 10 and domoticz.devices('Temperatuur Kamer Lars').temperature <= 19) then
				domoticz.devices('Roomlars-Stat').updateSetPoint(21).checkFirst().formin(30)
				--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
				domoticz.devices('Toon Scenes').switchSelector(40).checkFirst().formin(30)
				domoticz.log('Toon Scenes gezet op Comfort (40) omdat ddoor beweging in kamer Lars de verwarming daar is aangedaan')
			end
		end
	end
}
