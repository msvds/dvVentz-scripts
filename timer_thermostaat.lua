return {
	active = false,
	on = {
		timer = {'every 1 minutes'}
	},
	execute = function(domoticz, device)
		if (domoticz.time.matchesRule('at 16:32-21:33 on mon,tue,wed')) then
			if domoticz.devices('SomeoneHome').state == 'On' then
				domoticz.devices('Roomlars-Stat').updateSetPoint(10)
				--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
				domoticz.devices('Toon Scenes').switchSelector(40)
				domoticz.log('Toon Scenes gezet op Sleep (20) omdat')
			end
		end
	end
}
