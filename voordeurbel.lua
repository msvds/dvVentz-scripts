-- front door bell checks and actions are set here
return {
	active = true, -- set to false to disable this script
	on = {
		devices = {131}
	},
	execute = function(domoticz, device)
		local schemerlamp_deur = domoticz.devices(97)
		local lamp_spoelb_keuken = domoticz.devices(36)
		schemerlamp_bank.switchOn().forSec(1).repeatAfterSec(1, 3)		
		lamp_spoelb_keuken.switchOn().forSec(1).repeatAfterSec(1, 3)
		domoticz.notify('De deurbel gaat',"de deurbel gaat, doe open!",domoticz.PRIORITY_LOW)  
	end
}
