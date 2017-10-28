-- front door bell checks and actions are set here
-- test switch idx = 91
return {
	active = true, -- set to false to disable this script
	on = {
		devices = {131
		--,91
		}
	},
	execute = function(domoticz, device)
		local schemerlamp_deur = domoticz.devices(97)
		local lamp_spoelb_keuken = domoticz.devices(36)
		local lamp_boven_tv = domoticz.devices(13)
		local schemerlamp_bank = domoticz.devices(16)
		local schemerlamp_deur = domoticz.devices(97)		
		local lamp_hal_boven = domoticz.devices(151)
		local lamp_voordeur = domoticz.devices(33)
		schemerlamp_deur.switchOn().forSec(1).repeatAfterSec(2, 1)		
		--lamp_spoelb_keuken.switchOn().forSec(1).repeatAfterSec(1, 3)		
		lamp_boven_tv.switchOn().forSec(1).repeatAfterSec(2, 1)		
		schemerlamp_bank.switchOn().forSec(1).repeatAfterSec(2, 1)				
		lamp_hal_boven.switchOn().forSec(1).repeatAfterSec(2, 1)
		domoticz.notify('De deurbel gaat',"de deurbel gaat, doe open!",domoticz.PRIORITY_LOW)		
		if (IsDark == 'On') then
			if (lamp_voordeur.state == 'Off') then
				lamp_voordeur.switchOn()
				domoticz.log('Voordeurlamp aangezet omdat iemand aanbeld in het donker')
			end
		end
		schemerlamp_deur.switchOff().afterSec(30)
		lamp_boven_tv.switchOff().afterSec(30)
		schemerlamp_bank.switchOff().afterSec(30)
		lamp_hal_boven.switchOff().afterSec(30)
	end
}
