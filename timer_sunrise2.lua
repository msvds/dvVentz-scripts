return {
	active = true,
	on = {
		timer = {'every 1 minute between 10 minutes after sunrise and 15 minutes after sunrise'}
	},
	execute = function(domoticz, device)
		domoticz.helpers.switch_lights(domoticz,'Floor1','Off')
		domoticz.log('lampen woonkamer uitgezet ivm zonsopgang',domoticz.LOG_INFO)
		-- Gateway status resetten
		domoticz.devices('Xiaomi Gateway Alarm Ringtone eetkamer').switchSelector(0)
		domoticz.devices('Xiaomi Gateway Alarm Ringtone hal boven').switchSelector(0)
		domoticz.devices('Gateway light eetkamer').switchSelector(0)--off
		domoticz.devices('Gateway light hal boven').switchSelector(0)--off
		domoticz.log('Gateway status gereset')
	end
}