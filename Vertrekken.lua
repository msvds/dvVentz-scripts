return {
	active = true, -- set to false to disable this script
	logging = {marker = "Vertrekken"},
	on = {
		devices = {'Vertrekken'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Vertrekken').state == 'On') then
			-- Alles uit en beveiliging aanzetten bij gaan weggaan (away)
			domoticz.devices('Status').switchSelector(10) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
			domoticz.helpers.switch_lights(domoticz,'Inside','Off',0)
			domoticz.helpers.check_doors_and_windows(domoticz)
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(20)
			domoticz.log('Toon Scenes gezet op Sleep (20) omdat de gaan slapen knop ingedrukt is',domoticz.LOG_INFO)
			alarm.zones('My Home').armZone(domoticz, domoticz.SECURITY_ARMEDAWAY) -- This will  the zone "My Home" to "Armed Away" after the default exit delay
			domoticz.devices('Vertrekken').setState('Off').silent()
		end
	end
}
