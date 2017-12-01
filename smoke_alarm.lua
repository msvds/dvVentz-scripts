-- smoke alarm checks and notifications are set here
-- test switch idx = 91
return {
	active = true, -- set to false to disable this script
	on = {
		devices = {'Smoke Detector Zolder','Smoke Detector Keuken'
			--,'Test Switch'
		},
	},
	execute = function(domoticz, device)
		if (device.state == 'On') then
			domoticz.helpers.sendnotification(domoticz,'Brand!','Een rookmelder gaat af',domoticz.devices('Schemerlamp deur').state,domoticz.devices('Lamp spoelb keuken').state,domoticz.devices('Lamp boven TV').state,domoticz.devices('Schemerlamp bank').state,domoticz.devices('Lamp hal boven').state,1,180,1)
			if (device.name == 'Smoke Detector Zolder') then 
				domoticz.notify('Brand!', "De rookmelder in de hal boven gaat af" ,domoticz.PRIORITY_HIGH) 
			end
			if (device.name == 'Smoke Detector Keuken') then 
				domoticz.notify('Brand!', "De rookmelder in de keuken boven gaat af" ,domoticz.PRIORITY_HIGH) 
			end
			if (device.name == 'Test Switch') then 
				domoticz.notify('Brand alarm test!', "Dit was een test, niks aan de hand" ,domoticz.PRIORITY_HIGH) 
			end
		end
	end
}
