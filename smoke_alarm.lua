-- smoke alarm checks and notifications are set here
-- test switch idx = 91
return {
	active = true, -- set to false to disable this script
	on = {
		devices = {129,197
			,91
		},
	},
	execute = function(domoticz, device)
		local smoke_alarm_zolder = domoticz.devices(129)
		local smoke_alarm_keuken = domoticz.devices(197)
		local lamp_boven_tv = domoticz.devices(13)
		local lamp_spoelb_keuken = domoticz.devices(36)
		local lamp_bank = domoticz.devices(15)
		local schemerlamp_bank = domoticz.devices(16)
		local schemerlamp_deur = domoticz.devices(97)		
		local lamp_hal_boven = domoticz.devices(151)
		if (device.state == 'On') then
			--domoticz.devices(27).state == 'Accident tone'
			lamp_boven_tv.switchOn().forSec(1).repeatAfterSec(1, 10)
			lamp_spoelb_keuken.switchOn().forSec(1).repeatAfterSec(1, 10)
			lamp_bank.switchOn().forSec(1).repeatAfterSec(1, 10)
			schemerlamp_bank.switchOn().forSec(1).repeatAfterSec(1, 10)			
			schemerlamp_deur.switchOn().forSec(1).repeatAfterSec(1, 10)
			lamp_hal_boven.switchOn().forSec(1).repeatAfterSec(1, 10)			
			domoticz.notify('Brand!', "Een rookmelder gaat af" ,domoticz.PRIORITY_HIGH)
			domoticz.SOUND_SIREN
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
