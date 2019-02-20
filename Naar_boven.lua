return {
	active = true, -- set to false to disable this script
	logging = {marker = "Naar Boven"},
	on = {
		devices = {'Naar Boven'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Naar Boven').state == 'On') then
			-- Alles uit bij naar boven gaan
			domoticz.devices('Status').switchSelector(30) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
			domoticz.helpers.switch_lights(domoticz,'Floor1','Off',0)
			domoticz.helpers.check_doors_and_windows(domoticz)
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(20)
			domoticz.log('Toon Scenes gezet op Sleep (20) omdat de gaan slapen knop ingedrukt is',domoticz.LOG_INFO)
			domoticz.devices('Naar Boven').setState('Off').silent()
		end
	end
}
