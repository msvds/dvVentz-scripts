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
			if (domoticz.time.matchesRule('between sunset and 01:00') and domoticz.devices('Beweging woonkamer').state == 'On' and domoticz.devices('Sw1_woonkamerdeur').lastUpdate.minutesAgo > 3 and domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 3 and domoticz.devices('Sw4_eetkamerdeur').lastUpdate.minutesAgo > 3 and IsDark.state == 'On') then
				-- woonkamer aan avonds + donker
				-- between 16:00 and 1:00 then next day
				if (domoticz.groups('Lampen woonkamer').state == 'Off') then domoticz.log('Beweging woonkamer terwijl het donker is, lampen woonkamer aangezet', domoticz.LOG_INFO) end
				domoticz.groups('Lampen woonkamer').switchOn().checkFirst()
				domoticz.devices('White Temp Yeelight bank').dimTo(20)
				domoticz.devices('Yeelight Dimmer bank').dimTo(50)
				domoticz.devices('Yeelight bank').switchOn().checkFirst()				
			elseif (domoticz.time.matchesRule('between 15 minutes before sunset and sunset') and domoticz.devices('Beweging woonkamer').state == 'On' and domoticz.devices('Sw1_woonkamerdeur').lastUpdate.minutesAgo > 3 and domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 3 and domoticz.devices('Sw4_eetkamerdeur').lastUpdate.minutesAgo > 3 and IsDark.state == 'On') then
				-- woonkamer aan avonds + bijna donker
				if (domoticz.devices('Schemerlamp deur').state == 'Off') then domoticz.log('Beweging woonkamer avonds terwijl het donker is, schemerlamp deur aangezet', domoticz.LOG_INFO) end
				domoticz.devices('Schemerlamp deur').switchOn().checkFirst()
				if (domoticz.devices('Lamp spoelb keuken').state == 'Off') then domoticz.log('Beweging woonkamer avonds terwijl het donker is, lamp spoelbak keuken aangezet', domoticz.LOG_INFO) end
				domoticz.devices('Lamp spoelb keuken').switchOn().checkFirst()				
			elseif (domoticz.time.matchesRule('between 06:00 and sunrise') and domoticz.devices('Beweging woonkamer').state == 'On' and domoticz.devices('Sw1_woonkamerdeur').lastUpdate.minutesAgo > 3 and domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 3 and domoticz.devices('Sw4_eetkamerdeur').lastUpdate.minutesAgo > 3 and IsDark.state == 'On') then
				-- woonkamer ochtends + donker
				if (domoticz.devices('Schemerlamp deur').state == 'Off') then domoticz.log('Beweging woonkamer ochtends terwijl het donker is, schemerlamp deur aangezet', domoticz.LOG_INFO) end
				domoticz.devices('Schemerlamp deur').switchOn().checkFirst()
				if (domoticz.devices('Lamp spoelb keuken').state == 'Off') then domoticz.log('Beweging woonkamer ochtends terwijl het donker is, lamp spoelbak keuken aangezet', domoticz.LOG_INFO) end
				domoticz.devices('Lamp spoelb keuken').switchOn().checkFirst()				
			elseif (domoticz.time.matchesRule('at 01:00-06:00') and domoticz.devices('Beweging woonkamer').state == 'On'  and IsDark.state == 'On') then
				-- woonkamer nachts + donker
				if (domoticz.devices('Schemerlamp deur').state == 'Off') then domoticz.log('Beweging woonkamer snachts terwijl het donker is, schemerlamp deur aangezet', domoticz.LOG_INFO) end
				domoticz.devices('Schemerlamp deur').switchOn().checkFirst()				
				domoticz.log('Beweging nachts in de woonkamer!')			
			end
			if (domoticz.devices('Beweging hal boven').state == 'On' and domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 2 and IsDark.state == 'On') then
					-- hal aan donker
					-- vertraging zodat als Sw3_bed is ingedrukt, niet meteen de lamp in de hal weer aangaat omdat de bewegingsensor nog op On staat
					if (domoticz.devices('Lamp hal boven').state == 'Off') then domoticz.log('Beweging hal boven terwijl het donker is, lamp hal boven aangezet', domoticz.LOG_INFO) end
					domoticz.devices('Lamp hal boven').switchOn().checkFirst()
			end
			if (device.name == domoticz.devices('Slaapkamerdeur').name and domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 3 and domoticz.time.matchesRule('at 17:00-21:30') and domoticz.devices('Slaapkamerdeur').state == 'Open' and IsDark.state == 'On') then
				-- dimmers slaapkamer aan donker tot 0:30
				-- between 17:00 and 21:30
				if (domoticz.devices('Dimmer bed Martijn').state == 'Off') then
					domoticz.devices('Dimmer bed Martijn').dimTo(30)
					--domoticz.devices('Dimmer bed Martijn').switchOn()
					domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Martijn aangezet', domoticz.LOG_INFO)
				end
				if (domoticz.devices('Dimmer bed Suzanne').state == 'Off') then
					domoticz.devices('Dimmer bed Suzanne').dimTo(30)
					--domoticz.devices('Dimmer bed Suzanne').switchOn()
					domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Suzanne aangezet', domoticz.LOG_INFO)
				end
			elseif (device.name == domoticz.devices('Slaapkamerdeur').name and domoticz.time.matchesRule('at 21:30-0:30') and domoticz.devices('Slaapkamerdeur').state == 'Open' domoticz.devices('Sw3_bed').lastUpdate.minutesAgo > 3 and IsDark.state == 'On') then
				-- dimmers slaapkamer aan donker tot 0:30
				-- between 21:30 and 00:30 then next day
				if (domoticz.devices('Dimmer bed Martijn').state == 'Off') then
					domoticz.devices('Dimmer bed Martijn').dimTo(15)
					--domoticz.devices('Dimmer bed Martijn').switchOn()
					domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Martijn aangezet', domoticz.LOG_INFO)
				end
				if (domoticz.devices('Dimmer bed Suzanne').state == 'Off') then
					domoticz.devices('Dimmer bed Suzanne').dimTo(15)
					--domoticz.devices('Dimmer bed Suzanne').switchOn()
					domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Suzanne aangezet', domoticz.LOG_INFO)
				end
			end
			-- woonkamer aan donker + deur open
			if (domoticz.devices('Eetkamerdeur').state == 'Open' or domoticz.devices('Front door').state == 'Open') then
				if (domoticz.groups('Lampen woonkamer').state == 'Off') then domoticz.log('Eetkamerdeur of voordeur open bij thuiskomst terwijl het donker is, lampen woonkamer aangezet', domoticz.LOG_INFO) end
				domoticz.groups('Lampen woonkamer').switchOn().checkFirst()
				domoticz.groups('Lampen woonkamer').switchOn().checkFirst()
				domoticz.devices('White Temp Yeelight bank').dimTo(20)
				domoticz.devices('Yeelight Dimmer bank').dimTo(50)
				domoticz.devices('Yeelight bank').switchOn().checkFirst()
			end		
			if (domoticz.devices('Garage deur').state == 'Open') then
				-- buitenlampen aan donker + garage deur open
				if (domoticz.groups('Buitenlampen').state == 'Off') then domoticz.log('Garagedeur open terwijl het donker is, buitenlampen aangezet', domoticz.LOG_INFO) end
				domoticz.groups('Buitenlampen').switchOn().checkFirst()
			end
		end
		--if (domoticz.time.matchesRule('at 0:30-06:00') and domoticz.devices('Beweging woonkamer').state == 'On') then
			-- woonkamer aan nachts
			-- between 00:30 and 6:00
			--domoticz.groups('Lampen woonkamer').switchOn().forSec(1).repeatAfterSec(1, 150)
			--domoticz.groups('Lampen woonkamer').switchOn().afterSec(300)
			--domoticz.groups('Buitenlampen').switchOn().forSec(1).repeatAfterSec(1, 150)
			--domoticz.groups('Buitenlampen').switchOn().afterSec(300)
			--domoticz.notify('Beweging woonkamer terwijl het donker is, inbreker?', domoticz.PRIORITY_HIGH)
		--end
		--if (domoticz.time.matchesRule('at 0:30-06:00') and domoticz.devices('Beweging garage').state == 'On') then
			-- garage aan nachts
			-- between 00:30 and 6:00			
			--domoticz.groups('Lampen woonkamer').switchOn().forSec(1).repeatAfterSec(1, 150)
			--domoticz.groups('Lampen woonkamer').switchOn().afterSec(300)
			--domoticz.groups('Buitenlampen').switchOn().forSec(1).repeatAfterSec(1, 150)
			--domoticz.groups('Buitenlampen').switchOn().afterSec(300)
			--domoticz.notify('Beweging garage terwijl het donker is, inbreker?', domoticz.PRIORITY_HIGH)
		--end
		
		--verwarming
		if (domoticz.devices('Beweging kamer Lars').state == 'On') then
			domoticz.log('MC_PIR_kamerLars = ' ..domoticz.globalData.MC_PIR_kamerLars)
			if (domoticz.globalData.MC_PIR_kamerLars > 10 and domoticz.devices('Temperatuur Kamer Lars').temperature <= 19) then
				domoticz.devices('Roomlars-Stat').updateSetPoint(21)
				--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
				--domoticz.devices('Toon Scenes').switchSelector(40)
				--domoticz.log('Toon Scenes gezet op Comfort (40) omdat ddoor beweging in kamer Lars de verwarming daar is aangedaan')
			end
		end
	end
}
