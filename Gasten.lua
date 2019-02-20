return {
	active = true, -- set to false to disable this script
	logging = {marker = "Gasten"},
	on = {
		devices = {'Gasten'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Gasten').state == 'On') then
			domoticz.devices('Status').switchSelector(50) --0=Off/10=Away/20=Holiday/30=Sleep/40=Home/50=Guests/60=Home no notif
			-- Gateway status resetten
			domoticz.devices('Xiaomi Gateway Alarm Ringtone eetkamer').switchSelector(0)
			domoticz.devices('Xiaomi Gateway Alarm Ringtone hal boven').switchSelector(0)
			domoticz.devices('Gateway light eetkamer').switchSelector(0)--off
			domoticz.devices('Gateway light hal boven').switchSelector(0)--off
			domoticz.devices('Gasten').setState('Off').silent()
		end
	end
}
