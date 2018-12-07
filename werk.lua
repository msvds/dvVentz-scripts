return {
	active = true, -- set to false to disable this script
	logging = {marker = "Werk"},
	on = {
		devices = {'Werk'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Werk').state == 'On') then
			--activeer sfeerlichten
			domoticz.devices('Tradfri - Group - bar').dimTo(100)
			domoticz.devices('Tradfri - Group - boven tv').dimTo(100)
			domoticz.devices('Tradfri - Group - keuken').dimTo(100)			
			domoticz.devices('Tradfri - Group - hal').dimTo(100)
			domoticz.devices('Tradfri - Group - entree').dimTo(100)
			domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(100)
			domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(100)
			domoticz.devices('Sfeer').setState('Off')
		else
			--deactiveer sfeerlichten, terug naar normaal
			domoticz.devices('Tradfri - Group - bar').dimTo(50)
			domoticz.devices('Tradfri - Group - boven tv').dimTo(50)
			domoticz.devices('Tradfri - Group - keuken').dimTo(50)			
			domoticz.devices('Tradfri - Group - hal').dimTo(50)
			domoticz.devices('Tradfri - Group - entree').dimTo(50)
			domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(50)
			domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(50)
			domoticz.devices('Sfeer').setState('Off')
		end
	end
}
