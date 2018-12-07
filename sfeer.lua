return {
	active = true, -- set to false to disable this script
	logging = {marker = "Sfeer"},
	on = {
		devices = {'Sfeer'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Sfeer').state == 'On') then
			--activeer sfeerlichten
			domoticz.devices('Tradfri - Group - bar').dimTo(10)
			domoticz.devices('Tradfri - Group - boven tv').dimTo(10)
			domoticz.devices('Tradfri - Group - keuken').dimTo(10)			
			domoticz.devices('Tradfri - Group - hal').dimTo(10)
			domoticz.devices('Tradfri - Group - entree').dimTo(10)
			domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(10)
			domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(10)
			domoticz.devices('Werk').setState('Off').silent()
		else
			--deactiveer sfeerlichten, terug naar normaal
			domoticz.devices('Tradfri - Group - bar').dimTo(50)
			domoticz.devices('Tradfri - Group - boven tv').dimTo(50)
			domoticz.devices('Tradfri - Group - keuken').dimTo(50)			
			domoticz.devices('Tradfri - Group - hal').dimTo(50)
			domoticz.devices('Tradfri - Group - entree').dimTo(50)
			domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(50)
			domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(50)
			domoticz.devices('Werk').setState('Off').silent()
		end
	end
}
