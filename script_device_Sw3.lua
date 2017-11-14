return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Sw3'
		},
	},

	execute = function(domoticz, device)
		domoticz.devices('Status').switchSelector(30) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
		domoticz.helpers.switch_all_lights_off(domoticz)
		domoticz.helpers.check_doors_and_windows(domoticz)
		domoticz.helpers.changeSetPoint(domoticz,'10','omdat de gaan slapen knop ingedrukt is',false,currentSetpoint)
		alarm.zones('My Home').armZone(domoticz, domoticz.SECURITY_ARMEDHOME) -- This will  the zone "My Home" to "Armed Home" after the default exit delay
	end
}
