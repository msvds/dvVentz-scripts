return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Sw3_bed' -- Switch naast bed
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
			domoticz.devices('Status').switchSelector(40) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
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
			domoticz.devices('Lamp hal boven').switchOn().checkFirst()
			domoticz.log('Lights turned on')
		elseif device.state == 'Click' then
			-- Alles uit en beveiliging aanzetten bij gaan slapen (sleep)
			domoticz.devices('Status').switchSelector(30) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
			domoticz.helpers.switch_all_lights_off(domoticz)
			domoticz.helpers.check_doors_and_windows(domoticz)
			--domoticz.log('Huidige setpoint is '.. domoticz.helpers.currentSetpoint(domoticz))
			--domoticz.helpers.changeSetPoint(domoticz,'10','omdat de gaan slapen knop ingedrukt is',false,domoticz.helpers.currentSetpoint(domoticz))
			--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
			domoticz.devices('Toon Scenes').switchSelector(20)
			domoticz.log('Toon Scenes gezet op Sleep (20) omdat de gaan slapen knop ingedrukt is')
			alarm.zones('My Home').armZone(domoticz, domoticz.SECURITY_ARMEDHOME) -- This will  the zone "My Home" to "Armed Home" after the default exit delay
		elseif (device.state == 'Long Click') then
			-- Lampen aanzetten
			domoticz.devices('Status').switchSelector(40) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
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
			domoticz.devices('Lamp hal boven').switchOn().checkFirst()
			domoticz.log('Lights turned on')
		end		
	end
}
