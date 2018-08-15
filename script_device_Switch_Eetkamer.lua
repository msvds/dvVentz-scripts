return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Single Wall Switch Lampen Eetkamer'
		},
	},

	execute = function(domoticz, device)
			if (domoticz.devices('Yeelight eetkamer 1').state == 'On') then
				domoticz.devices('Yeelight eetkamer 1').switchOff().checkFirst()	
			end
			if (domoticz.devices('Yeelight eetkamer 1').state == 'Off' ) then
				domoticz.devices('White Temp Yeelight eetkamer 1').dimTo(20)
				domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(50)
				domoticz.devices('Yeelight eetkamer 1').switchOn().checkFirst()	
			end
			if (domoticz.devices('Yeelight eetkamer 2').state == 'On' ) then
				domoticz.devices('Yeelight eetkamer 2').switchOff().checkFirst()
			end
			if (domoticz.devices('Yeelight eetkamer 2').state == 'Off' ) then
				domoticz.devices('White Temp Yeelight eetkamer 2').dimTo(20)
				domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(50)
				domoticz.devices('Yeelight eetkamer 2').switchOn().checkFirst()
			end
		end	
	end
}
