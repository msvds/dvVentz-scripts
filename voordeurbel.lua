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
		testing_on = false
		local test_switch = domoticz.devices(91)
		local Time = require('Time')
		local lamp_hal_boven = domoticz.devices(151)
		local schemerlamp_deur = domoticz.devices(97)
		local lamp_spoelb_keuken = domoticz.devices(36)
		local schemerlamp_bank = domoticz.devices(16)
		local lamp_boven_tv = domoticz.devices(13)
		local lamp_voordeur = domoticz.devices(33)
		local IsDark = domoticz.devices(78)
		debug = false			
		domoticz.helpers.sendnotification('De deurbel gaat','Er staat iemand voor de deur, misschien open doen?',schemerlamp_deur.state,lamp_spoelb_keuken.state,lamp_boven_tv.state,schemerlamp_bank.state,lamp_hal_boven.state,1,2,1)
		if (IsDark == 'On') then
			if (lamp_voordeur.state == 'Off') then
				lamp_voordeur.switchOn()
				domoticz.log('Voordeurlamp aangezet omdat iemand aanbelt in het donker')
			end
		end
	end
}

