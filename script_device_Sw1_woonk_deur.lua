return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Sw1_woonkamerdeur' -- Switch naast woonkamerdeur
		},
	},

	execute = function(domoticz, device)
		local alarm = require "ideAlarmModule"
		if device.state == 'Double Click' then
			-- Beveiliging uitzetten (thuis)
			domoticz.devices('Status').switchSelector(40) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
			for i=1, alarm.qtyAlarmZones() do
				alarm.zones(i).disArmZone(domoticz)
			end
			-- Lampen aanzetten
			if IsDark.state == 'On' then
				domoticz.devices('Status').switchSelector(40) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
				domoticz.devices('Lamp boven TV').switchOn().checkFirst()
				domoticz.devices('Lamp spoelb keuken').switchOn().checkFirst()
				domoticz.devices('Lamp ster').switchOn().checkFirst()
				domoticz.devices('Yeelight bank').switchOn().checkFirst()
				domoticz.devices('Schemerlamp bank').switchOn().checkFirst()
				domoticz.devices('Schemerlamp deur').switchOn().checkFirst()
				domoticz.log('Lights turned on')
			end
		elseif device.state == 'Click' then
			-- Alles uit bij gaan slapen (sleep)
			domoticz.devices('Status').switchSelector(30) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
			domoticz.helpers.switch_lights_off(domoticz,'Floor1')
			domoticz.helpers.check_doors_and_windows(domoticz)
			--domoticz.log('Huidige setpoint is '.. domoticz.helpers.currentSetpoint(domoticz))
			--domoticz.helpers.changeSetPoint(domoticz,'10','omdat de gaan slapen knop ingedrukt is',false,domoticz.helpers.currentSetpoint(domoticz))
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(20)
			domoticz.log('Toon Scenes gezet op Sleep (20) omdat de gaan slapen knop ingedrukt is')
			--alarm.zones('My Home').armZone(domoticz, domoticz.SECURITY_ARMEDHOME) -- This will  the zone "My Home" to "Armed Home" after the default exit delay
		elseif (device.state == 'Long Click') then
			-- Lampen aanzetten
			domoticz.devices('Status').switchSelector(40) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
			domoticz.devices('Lamp boven TV').switchOn().checkFirst()
			domoticz.devices('Lamp spoelb keuken').switchOn().checkFirst()
			domoticz.devices('Lamp ster').switchOn().checkFirst()
			domoticz.devices('Yeelight bank').switchOn().checkFirst()
			domoticz.devices('Schemerlamp bank').switchOn().checkFirst()
			domoticz.devices('Schemerlamp deur').switchOn().checkFirst()
			domoticz.log('Lights turned on')
		end		
	end
}
