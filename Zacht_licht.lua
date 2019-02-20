return {
	active = true, -- set to false to disable this script
	logging = {marker = "Zacht licht"},
	on = {
		devices = {'Zacht licht'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Zacht licht').state == 'On') then
			--activeer sfeerlichten
			domoticz.devices('Tradfri - Group - bar').dimTo(10)
			domoticz.devices('Tradfri - Group - boven tv').dimTo(10)
			domoticz.devices('Tradfri - Group - keuken').dimTo(10)			
			domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(10)
			domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(10)
			domoticz.devices('Normaal licht').setState('Off').silent()
			domoticz.devices('Zacht licht').setState('Off').silent()
			domoticz.devices('Fel licht').setState('Off').silent()
		else
			domoticz.helpers.switch_lights(domoticz,'Floor1','Off',0)
			domoticz.devices('Normaal licht').setState('Off').silent()
			domoticz.devices('Zacht licht').setState('Off').silent()
			domoticz.devices('Fel licht').setState('Off').silent()			
		end
	end
}
