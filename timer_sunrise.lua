return {
	active = true,
	on = {
		timer = {'every 1 minute between sunrise and 5 minutes after sunrise'}
	},
	execute = function(domoticz, device)
		domoticz.helpers.switch_lights(domoticz,'Outside','Off')
		domoticz.log('lampen buiten uitgezet ivm zonsopgang en nacht',domoticz.LOG_INFO)
		domoticz.groups('Lampen woonkamer').switchOff().checkFirst().afterMin(10)
		domoticz.log('lampen woonkamer uitgezet ivm zonsopgang',domoticz.LOG_INFO)
		domoticz.devices('Schemerlamp deur').switchOff().checkFirst().afterMin(10)
		domoticz.log('Schemerlamp deur uitgezet ivm zonsopgang', domoticz.LOG_INFO)
		domoticz.devices('Lamp spoelb keuken').switchOff().checkFirst().afterMin(10)
		domoticz.log('Lamp spoelbak keuken uitgezet ivm zonsopgang', domoticz.LOG_INFO)
		domoticz.devices('Yeelight eetkamer 1').switchOff().checkFirst().afterMin(10)
		domoticz.devices('Yeelight eetkamer 2').switchOff().checkFirst().afterMin(10)
		domoticz.devices('Lamp ster').switchOff().checkFirst().afterMin(10)
		domoticz.log('Lamp ster uitgezet ivm zonsopgang', domoticz.LOG_INFO)
		-- Gateway status resetten
		domoticz.devices('Xiaomi Gateway Alarm Ringtone eetkamer').switchSelector(0)
		domoticz.devices('Xiaomi Gateway Alarm Ringtone hal boven').switchSelector(0)
		domoticz.devices('Gateway light eetkamer').switchSelector(0)--off
		domoticz.devices('Gateway light hal boven').switchSelector(0)--off
		domoticz.log('Gateway status gereset')
	end
}
