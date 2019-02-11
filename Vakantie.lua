return {
	active = true, -- set to false to disable this script
	logging = {marker = "Vakantie"},
	on = {
		devices = {'Vakantie'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Vakantie').state == 'On') then
			-- Alles uit en beveiliging aanzetten bij vertrek naar vakantie
			domoticz.devices('Status').switchSelector(20) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
			domoticz.helpers.switch_lights(domoticz,'Inside','Off',0)
			domoticz.devices('Yeelight light slaapkamer').switchSelector(0)
			domoticz.helpers.check_doors_and_windows(domoticz)
			alarm.zones('My Home').armZone(domoticz, domoticz.SECURITY_ARMEDHOME) -- This will  the zone "My Home" to "Armed Home" after the default exit delay
			domoticz.devices('Toon Scenes').switchSelector(20)
			domoticz.log('Toon Scenes gezet op Sleep (20) omdat de gaan slapen knop ingedrukt is',domoticz.LOG_INFO)
			-- Gateway status resetten
			domoticz.devices('Xiaomi Gateway Alarm Ringtone eetkamer').switchSelector(0)
			domoticz.devices('Xiaomi Gateway Alarm Ringtone hal boven').switchSelector(0)
			domoticz.devices('Gateway light eetkamer').switchSelector(0)--off
			domoticz.devices('Gateway light hal boven').switchSelector(0)--off
		end
	end
}
