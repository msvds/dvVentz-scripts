return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'IsDonker (virt)'
		},
	},

	execute = function(domoticz, device)
		debug = false	
		local Time = require('Time')
		if debug == true then domoticz.log('IsDark.state = ' ..IsDark.state) end
		if (domoticz.devices('IsDonker (virt)').state == 'Off') then
			domoticz.groups('Lampen woonkamer').switchOff().checkFirst().afterMin(10)
			domoticz.log('lampen woonkamer uitgezet ivm zonsopgang')
			domoticz.devices('Schemerlamp deur').switchOff().checkFirst().afterMin(10)
			domoticz.log('Schemerlamp deur uitgezet ivm zonsopgang', domoticz.LOG_INFO)
			domoticz.devices('Lamp spoelb keuken').switchOff().checkFirst().afterMin(10)
			domoticz.log('Lamp spoelbak keuken uitgezet ivm zonsopgang', domoticz.LOG_INFO)
		end
	end
}
