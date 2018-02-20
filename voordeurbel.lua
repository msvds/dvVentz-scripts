-- front door bell checks and actions are set here
-- test switch idx = 91
return {
	active = true, -- set to false to disable this script
	on = {
		devices = {'Voordeurbel'
		--,'Test Switch'
		}
	},
	execute = function(domoticz, device)
		if domoticz.devices('Voordeurbel').state == 'Group On' then			
			local Time = require('Time')
			domoticz.devices('Xiaomi Gateway Doorbell hal boven').switchSelector(10)
			local sceneCmd = 'curl -s -i -H "Accept: application/json" "http://192.168.178.3:8084/json.htm?type=command&param=setcolbrightnessvalue&idx=53&hue=236&brightness=1&iswhite=false"'
			os.execute(sceneCmd)

			domoticz.devices('Xiaomi Gateway Doorbell eetkamer').switchSelector(10)
			local sceneCmd = 'curl -s -i -H "Accept: application/json" "http://192.168.178.37:8084/json.htm?type=command&param=setcolbrightnessvalue&idx=54&hue=236&brightness=1&iswhite=false"'
			os.execute(sceneCmd)

			domoticz.helpers.sendnotification(domoticz,'De deurbel gaat','Er staat iemand voor de deur')
			--domoticz.helpers.flash_lights(domoticz,domoticz.devices('Schemerlamp deur').state,domoticz.devices('Lamp spoelb keuken').state,domoticz.devices('Lamp boven TV').state,domoticz.devices('Schemerlamp bank').state,domoticz.devices('Lamp hal boven').state,1,2,1)
			if (domoticz.devices('IsDonker (virt)').state == 'On') then
				domoticz.devices('Voordeurlamp').switchOn().checkFirst()
				domoticz.log('Voordeurlamp aangezet omdat iemand aanbelt in het donker')
			end
		end
	end
}

