return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Reset Domoticz'
		},
	},
	execute = function(domoticz, device)
		domoticz.groups('Lampen woonkamer').switchOff().checkFirst()
		domoticz.devices('Yeelight eetkamer 1').switchOff().checkFirst()
		domoticz.devices('Yeelight eetkamer 2').switchOff().checkFirst()
		domoticz.devices('Schemerlamp deur').switchOff().checkFirst()
		domoticz.devices('Lamp spoelb keuken').switchOff().checkFirst()
		domoticz.devices('Lamp hal boven').switchOff()
		domoticz.devices('Yeelight slaapkamer').switchOff().checkFirst()				
		domoticz.devices('Dimmer bed Martijn').switchOff()
		domoticz.devices('Dimmer bed Suzanne').switchOff()
		domoticz.log('Lampen uitgezet')
		domoticz.devices('Roomlars-Stat').updateSetPoint(10)
		domoticz.devices('Bathroom-Stat').updateSetPoint(10)
		domoticz.devices('Chillroom-Stat').updateSetPoint(10)
		domoticz.devices('Roomnienke-Stat').updateSetPoint(10)
		domoticz.log('Thermostaat kranen op 10 graden gezet')
		--0=Off/10=Away/20=Sleep/30=Home/40=Comfort/50=Manual
		domoticz.devices('Toon Scenes').switchSelector(30)
		domoticz.log('Thermostaat op Home gezet')
		local alarm = require "ideAlarmModule"
		alarm.zones('My Home').disArmZone(domoticz)
		domoticz.log('Alarm uitgezet')
		-- Gateway status resetten
		domoticz.devices('Xiaomi Gateway Alarm Ringtone eetkamer').switchSelector(0)
		domoticz.devices('Xiaomi Gateway Alarm Ringtone hal boven').switchSelector(0)
		domoticz.devices('Gateway light eetkamer').switchSelector(0)--off
		domoticz.devices('Gateway light hal boven').switchSelector(0)--off
		domoticz.log('Gateway status gereset')
		domoticz.devices('Status').switchSelector(40) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
		domoticz.log('Status op Home gezet')
		domoticz.helpers.switch_lights(domoticz,'All','Off')
	end
}
