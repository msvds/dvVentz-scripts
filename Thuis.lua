return {
	active = true, -- set to false to disable this script
	logging = {marker = "Thuis"},
	on = {
		devices = {
			'Thuis'
		},
	},
	execute = function(domoticz, device)
		domoticz.helpers.change_heat(domoticz,'Inside','Home')
		local alarm = require "ideAlarmModule"
		alarm.zones('My Home').disArmZone(domoticz)
		domoticz.log('Alarm uitgezet',domoticz.LOG_INFO)
		-- Gateway status resetten
		domoticz.devices('Xiaomi Gateway Alarm Ringtone eetkamer').switchSelector(0)
		domoticz.devices('Xiaomi Gateway Alarm Ringtone hal boven').switchSelector(0)
		domoticz.devices('Gateway light eetkamer').switchSelector(0)--off
		domoticz.devices('Gateway light hal boven').switchSelector(0)--off
		domoticz.log('Gateway status gereset',domoticz.LOG_INFO)
		domoticz.devices('Status').switchSelector(40) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
		domoticz.log('Status op Home gezet',domoticz.LOG_INFO)
		domoticz.devices('Thuis').setState('Off').silent()
	end
}
