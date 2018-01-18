return {
	active = true,
	on = {
		timer = {'every 1 minute between sunrise and 5 minutes after sunrise'}
	},
	execute = function(domoticz, device)
		domoticz.groups('Buitenlampen').switchOff().checkFirst()
		domoticz.log('lampen buiten uitgezet ivm zonsopgang en nacht')
		domoticz.groups('Lampen woonkamer').switchOff().checkFirst()
		domoticz.log('lampen woonkamer uitgezet ivm zonsopgang')
		domoticz.devices('Schemerlamp deur').switchOff().checkFirst()
		domoticz.log('Schemerlamp deur uitgezet ivm zonsopgang', domoticz.LOG_INFO)
		domoticz.devices('Lamp spoelb keuken').switchOff().checkFirst()
		domoticz.log('Lamp spoelbak keuken uitgezet ivm zonsopgang', domoticz.LOG_INFO)
		domoticz.devices('Yeelight bank').switchOff().checkFirst()
		domoticz.devices('Lamp ster').switchOff().checkFirst()
		domoticz.log('Lamp ster uitgezet ivm zonsopgang', domoticz.LOG_INFO)
		
	end
}
