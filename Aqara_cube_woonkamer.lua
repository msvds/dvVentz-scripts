return {
	active = true, -- set to false to disable this script
	logging = {marker = "Aqara_cube_woonkamer"},
	on = {
		devices = {'Aqara Cube woonkamer'},
	},

	execute = function(domoticz, device)
		if (device.state == 'flip90') then
			--activeer Normaal
			domoticz.devices('Tradfri - Group - bar').dimTo(50)
		elseif (device.state == 'flip180') then
			--deactiveer Normaal, normaal uit
			domoticz.devices('Tradfri - Group - bar').dimTo(5)
		end
	end
}
