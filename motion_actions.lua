return {
	active = true, -- set to false to disable this script
	on = {
		devices = {'Eetkamerdeur','Dakraam slaapkamer','Balkondeur slaapkamer','Front door','Balkondeur Nienke','Slaapkamerdeur','Deur bijkeuken','Zolderdakraam achter','Garage deur','Beweging woonkamer','Beweging kamer Lars','Beweging hal boven','Dimmer bed Martijn','Dimmer bed Suzanne','Lampen woonkamer','Lamp hal boven','Schemerlamp deur','Lamp spoelb keuken'},
	},

	execute = function(domoticz, device)
		debug = true
		local IsDark = domoticz.devices(78)
		local SomeoneHome = domoticz.devices(96)
		local Time = require('Time')
		--domoticz.log('IsDark.state = ' ..IsDark.state)
		if IsDark.state == 'On' then			
			if (domoticz.time.matchesRule('at 16:00-01:00') and domoticz.devices('Beweging woonkamer').state == 'On') then
				-- woonkamer aan avonds + donker
				-- between 16:00 and 1:00 then next day
				domoticz.groups('Lampen woonkamer').switchOn().checkFirst()
				domoticz.log('Beweging woonkamer terwijl het donker is, lampen woonkamer aangezet', domoticz.LOG_INFO)

			elseif (domoticz.time.matchesRule('at 06:00-09:00') and domoticz.devices('Beweging woonkamer').state == 'On' and domoticz.devices('Sw1').lastUpdate.minutesAgo > 30) then
				-- woonkamer ochtends + donker
				domoticz.devices('Schemerlamp deur').switchOn().checkFirst()
				domoticz.log('Beweging woonkamer ochtends terwijl het donker is, schemerlamp deur aangezet', domoticz.LOG_INFO)
				domoticz.devices('Lamp spoelb keuken').switchOn().checkFirst()
				domoticz.log('Beweging woonkamer ochtends terwijl het donker is, lamp spoelbak keuken aangezet', domoticz.LOG_INFO)
			elseif (domoticz.time.matchesRule('at 01:00-06:00') and domoticz.devices('Beweging woonkamer').state == 'On') then
				-- woonkamer nachts + donker
				domoticz.log('Beweging nachts in de woonkamer!')			
			end
			if (domoticz.devices('Beweging hal boven').state == 'On') then
				if (domoticz.devices('Sw3').lastUpdate.minutesAgo > 2) then
					-- hal aan donker
					-- vertraging zodat als Sw3 is ingedrukt, niet meteen de lamp in de hal weer aangaat omdat de bewegingsensor nog op On staat
					domoticz.devices('Lamp hal boven').switchOn().checkFirst()
					domoticz.log('Beweging hal boven terwijl het donker is, lamp hal boven aangezet', domoticz.LOG_INFO)
				end
			end
			if (device.name == domoticz.devices('Slaapkamerdeur').name and domoticz.time.matchesRule('at 17:00-21:30') and domoticz.devices('Slaapkamerdeur').state == 'Open') then
				-- dimmers slaapkamer aan donker tot 0:30
				-- between 17:00 and 21:30
				if (domoticz.devices('Dimmer bed Martijn').state == 'Off') then
					domoticz.devices('Dimmer bed Martijn').dimTo(20)
					--domoticz.devices('Dimmer bed Martijn').switchOn()
					domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Martijn aangezet', domoticz.LOG_INFO)
				end
				if (domoticz.devices('Dimmer bed Suzanne').state == 'Off') then
					domoticz.devices('Dimmer bed Suzanne').dimTo(20)
					--domoticz.devices('Dimmer bed Suzanne').switchOn()
					domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Suzanne aangezet', domoticz.LOG_INFO)
				end
			elseif (device.name == domoticz.devices('Slaapkamerdeur').name and domoticz.time.matchesRule('at 21:30-0:30') and domoticz.devices('Slaapkamerdeur').state == 'Open') then
				-- dimmers slaapkamer aan donker tot 0:30
				-- between 21:30 and 00:30 then next day
				if (domoticz.devices('Dimmer bed Martijn').state == 'Off') then
					domoticz.devices('Dimmer bed Martijn').dimTo(8)
					--domoticz.devices('Dimmer bed Martijn').switchOn()
					domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Martijn aangezet', domoticz.LOG_INFO)
				end
				if (domoticz.devices('Dimmer bed Suzanne').state == 'Off') then
					domoticz.devices('Dimmer bed Suzanne').dimTo(8)
					--domoticz.devices('Dimmer bed Suzanne').switchOn()
					domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Suzanne aangezet', domoticz.LOG_INFO)
				end
			end
			if (SomeoneHome.state == 'Off') then
				-- woonkamer aan donker + deur open
				if (domoticz.devices('Eetkamerdeur').state == 'Open' or domoticz.devices('Front door').state == 'Open') then
					domoticz.groups('Lampen woonkamer').switchOn().checkFirst()
					domoticz.log('Eetkamerdeur of voordeur open terwijl het donker is, lampen woonkamer aangezet', domoticz.LOG_INFO)
				end
			end			
			if (domoticz.devices('Garage deur').state == 'Open') then
				-- buitenlampen aan donker + garage deur open
				domoticz.groups('Buitenlampen').switchOn().checkFirst()
				domoticz.log('Garagedeur open terwijl het donker is, buitenlampen aangezet', domoticz.LOG_INFO)
			end
		else
			if (domoticz.time.matchesRule('at 0:30-06:00') and domoticz.devices('Beweging woonkamer').state == 'On') then
				-- woonkamer aan nachts
				-- between 00:30 and 6:00
				domoticz.groups('Lampen woonkamer').switchOn().forSec(1).repeatAfterSec(1, 150)
				domoticz.groups('Lampen woonkamer').switchOn().afterSec(300)
				domoticz.groups('Buitenlampen').switchOn().forSec(1).repeatAfterSec(1, 150)
				domoticz.groups('Buitenlampen').switchOn().afterSec(300)
				domoticz.notify('Beweging woonkamer terwijl het donker is, inbreker?', domoticz.PRIORITY_HIGH)
			end
			if (domoticz.time.matchesRule('at 0:30-06:00') and domoticz.devices('Beweging garage').state == 'On') then
				-- garage aan nachts
				-- between 00:30 and 6:00			
				domoticz.groups('Lampen woonkamer').switchOn().forSec(1).repeatAfterSec(1, 150)
				domoticz.groups('Lampen woonkamer').switchOn().afterSec(300)
				domoticz.groups('Buitenlampen').switchOn().forSec(1).repeatAfterSec(1, 150)
				domoticz.groups('Buitenlampen').switchOn().afterSec(300)
				domoticz.notify('Beweging garage terwijl het donker is, inbreker?', domoticz.PRIORITY_HIGH)
			end
		end
	end
}
