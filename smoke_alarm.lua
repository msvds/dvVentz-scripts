-- smoke alarm checks and notifications are set here
return {
	active = true, -- set to false to disable this script
	on = {
		devices = {129,197}
    },
    execute = function(domoticz, SmokeAlarm)
		local smoke_alarm_zolder = domoticz.devices(129)
		local smoke_alarm_keuken = domoticz.devices(197)
		local lamp_boven_tv = domoticz.devices(13)
		local lamp_boven_tv = domoticz.devices(13)
		local lamp_spoelb_keuken = domoticz.devices(36)
		local lamp_bank = domoticz.devices(15)
		local schemerlamp_bank = domoticz.devices(16)
		local schemerlamp_deur = domoticz.devices(97)		
		local lamp_hal_boven = domoticz.devices(151)
		if (SmokeAlarm.state == 'On') then
			--domoticz.devices(27).state == 'Accident tone'
			lamp_boven_tv.switchOn().forSec(1).repeatAfterSec(1, 10)
			lamp_spoelb_keuken.switchOn().forSec(1).repeatAfterSec(1, 10)
			lamp_bank.switchOn().forSec(1).repeatAfterSec(1, 10)
			schemerlamp_bank.switchOn().forSec(1).repeatAfterSec(1, 10)
			schemerlamp_deur.switchOn().forSec(1).repeatAfterSec(1, 10)			
			schemerlamp_deur.switchOn().forSec(1).repeatAfterSec(1, 10)
			lamp_hal_boven.switchOn().forSec(1).repeatAfterSec(1, 10)			
			domoticz.notify('Brand!', "Een rookmelder gaat af" ,domoticz.PRIORITY_HIGH) 
			if (smoke_alarm_zolder.state == 'On') then 
				domoticz.notify('Brand!', "De rookmelder in de hal boven gaat af" ,domoticz.PRIORITY_HIGH) 
			end
			if (smoke_alarm_keuken.state == 'On') then 
				domoticz.notify('Brand!', "De rookmelder in de keuken boven gaat af" ,domoticz.PRIORITY_HIGH) 
			end
        end
	end
}

