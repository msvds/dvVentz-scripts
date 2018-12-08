return {
	active = true, -- set to false to disable this script
	logging = {marker = "script_device_Switch_Keuken"},
	on = {
		devices = {
			'Dual Wall Switch Keuken' -- Dual Wall Switch Keuken
		},
	},

	execute = function(domoticz, device)
		if device.state == 'Switch 1' then
			if (domoticz.devices('Tradfri - Group - bar').state == 'Off') then
				domoticz.devices('Tradfri - Group - bar').switchOn()	
				domoticz.log('Lampen bar aangezet')
			else
				domoticz.devices('Tradfri - Group - bar').switchOff()	
				domoticz.log('Lampen bar uitgezet')
			end
		elseif device.state == 'Switch 2' then
			if (domoticz.devices('Tradfri - Group - keuken').state == 'Off') then
				domoticz.devices('Tradfri - Group - keuken').switchOn()
				domoticz.devices('Lamp spoelb keuken').switchOn()
				domoticz.log('Lampen keuken aangezet')
			else
				domoticz.devices('Tradfri - Group - keuken').switchOff()
				domoticz.devices('Lamp spoelb keuken').switchOff()
				domoticz.log('Lampen keuken uitgezet')
			end
			
		elseif (device.state == 'Both_Click') then
			if (domoticz.devices('Tradfri - Group - bar').state == 'Off') then
				domoticz.devices('Tradfri - Group - bar').switchOn()	
				domoticz.log('Lampen bar aangezet')
			else
				domoticz.devices('Tradfri - Group - bar').switchOff()	
				domoticz.log('Lampen bar uitgezet')
			end
			if (domoticz.devices('Tradfri - Group - keuken').state == 'Off') then
				domoticz.devices('Tradfri - Group - keuken').switchOn()
				domoticz.devices('Lamp spoelb keuken').switchOn()
				domoticz.log('Lampen keuken aangezet')
			else
				domoticz.devices('Tradfri - Group - keuken').switchOff()
				domoticz.devices('Lamp spoelb keuken').switchOff()
				domoticz.log('Lampen keuken uitgezet')
			end
		end		
	end
}
