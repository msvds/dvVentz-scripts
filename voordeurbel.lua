-- front door bell checks and actions are set here
return {
	active = true, -- set to false to disable this script
	on = {
		devices = {131}
	},
	execute = function(domoticz, device)
		local schemerlamp_deur = domoticz.devices(97)
		local lamp_spoelb_keuken = domoticz.devices(36)
		local lamp_boven_tv = domoticz.devices(13)
		local schemerlamp_bank = domoticz.devices(16)
		local schemerlamp_deur = domoticz.devices(97)		
		local lamp_hal_boven = domoticz.devices(151)		
		schemerlamp_deur.switchOn().forSec(1).repeatAfterSec(2, 3)		
		lamp_spoelb_keuken.switchOn().forSec(1).repeatAfterSec(2, 3)		
		lamp_boven_tv.switchOn().forSec(1).repeatAfterSec(2, 3)		
		schemerlamp_bank.switchOn().forSec(1).repeatAfterSec(2, 3)				
		lamp_hal_boven.switchOn().forSec(1).repeatAfterSec(2, 3)
		domoticz.notify('De deurbel gaat',"de deurbel gaat, doe open!",domoticz.PRIORITY_LOW)  
	end
}
