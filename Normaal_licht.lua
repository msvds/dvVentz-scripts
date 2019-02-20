return {
	active = true, -- set to false to disable this script
	logging = {marker = "Normaal_licht"},
	on = {
		devices = {'Normaal licht'},
	},

	execute = function(domoticz, device)
		if (domoticz.devices('Normaal licht').state == 'On') then
			--activeer Normaal
			domoticz.devices('Tradfri - Group - bar').dimTo(50)
			domoticz.devices('Tradfri - Group - boven tv').dimTo(50)
			domoticz.devices('Tradfri - Group - keuken').dimTo(50)			
			domoticz.devices('Yeelight Dimmer eetkamer 1').dimTo(50)
			domoticz.devices('Yeelight Dimmer eetkamer 2').dimTo(50)
			domoticz.devices('Normaal licht').setState('Off').silent()
			domoticz.devices('Zacht licht').setState('Off').silent()
			domoticz.devices('Fel licht').setState('Off').silent()
		else
			--deactiveer Normaal, normaal uit
			domoticz.helpers.switch_lights(domoticz,'Floor1','Off',0)
			domoticz.devices('Normaal licht').setState('Off').silent()
			domoticz.devices('Zacht licht').setState('Off').silent()
			domoticz.devices('Fel licht').setState('Off').silent()
		end
	end
}
