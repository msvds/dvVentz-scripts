return {
	active = true,
	logging = {marker = "timer_thermostaat"},
	on = {
		timer = {'every 1 minutes'}
	},
	execute = function(domoticz, device)
		local Time = require('Time')		
		if (domoticz.time.matchesRule('at 7:30-7:35 on mon,tue,wed,thu,fri') and domoticz.devices('SomeoneHome').state == 'On') then				
			domoticz.devices('Toon Auto Program').state = 'No'
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(30)
			domoticz.log('Thermostaat timer programma: Scenes gezet op Home (30)',domoticz.LOG_INFO)
		end
		if (domoticz.time.matchesRule('at 8:00-8:05 on mon,tue')) then			
			domoticz.devices('Toon Auto Program').state = 'No'
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(10)
			domoticz.log('Thermostaat timer programma: Scenes gezet op Away (10)',domoticz.LOG_INFO)
		end
		if (domoticz.time.matchesRule('at 14:00-14:05 on mon') and domoticz.devices('SomeoneHome').state == 'On') then				
			domoticz.devices('Toon Auto Program').state = 'No'
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(30)
			domoticz.log('Thermostaat timer programma: Scenes gezet op Home (30)',domoticz.LOG_INFO)
		end
		if (domoticz.time.matchesRule('at 17:00-17:05 on mon,wed,thu,fri') and domoticz.devices('SomeoneHome').state == 'On') then				
			domoticz.devices('Toon Auto Program').state = 'No'
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(30)
			domoticz.log('Thermostaat timer programma: Scenes gezet op Home (30)',domoticz.LOG_INFO)
		end
		if (domoticz.time.matchesRule('at 18:10-18:15 on tue') and domoticz.devices('SomeoneHome').state == 'On') then				
			domoticz.devices('Toon Auto Program').state = 'No'
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(30)
			domoticz.log('Thermostaat timer programma: Scenes gezet op Home (30)',domoticz.LOG_INFO)
		end
		if (domoticz.time.matchesRule('at 23:55-23:59')) then				
			domoticz.devices('Toon Auto Program').state = 'No'
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(20)
			domoticz.log('Thermostaat timer programma: Scenes gezet op Sleep (20)',domoticz.LOG_INFO)
			domoticz.devices('Roomlars-Stat').updateSetPoint(10)
			domoticz.devices('Bathroom-Stat').updateSetPoint(10)
			domoticz.devices('Chillroom-Stat').updateSetPoint(10)
			domoticz.devices('Roomnienke-Stat').updateSetPoint(10)
			domoticz.log('Alle thermostaatkranen teruggezet op 10 graden volgens timer programma',domoticz.LOG_INFO)
		end
		if (domoticz.time.matchesRule('at 21:15-21:20 on mon,tue,wed,thu,fri')) then				
			domoticz.devices('Toon Auto Program').state = 'No'
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(20)
			domoticz.log('Thermostaat timer programma: Scenes gezet op Sleep (20)',domoticz.LOG_INFO)
		end
		if (domoticz.time.matchesRule('at 22:15-22:20 on sat,sun')) then				
			domoticz.devices('Toon Auto Program').state = 'No'
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(20)
			domoticz.log('Thermostaat timer programma: Scenes gezet op Sleep (20)',domoticz.LOG_INFO)
		end
		
	end
}
