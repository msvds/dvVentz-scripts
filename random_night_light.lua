return {
	active = true, -- set to false to disable this script
	on = {
		['timer'] = {
			'every 30 minutes between sunset and 23:59'
		}
	},
	execute = function(domoticz, device)
		local Time = require('Time')
		-- On during holiday (armed away house)	
		if (domoticz.security == domoticz.SECURITY_ARMEDAWAY) then
			if (domoticz.devices('Lamp spoelb keuken').state == 'Off') then
				domoticz.devices('Lamp spoelb keuken').switchOn().withinMin(27).forMin(2)
				domoticz.log('Lamp spoelbak keuken aangezet met random timer ivm inbraakpreventie', domoticz.LOG_INFO)
			end
			if (domoticz.devices('Lamp boven TV').state == 'Off') then
				domoticz.devices('Lamp boven TV').switchOn().withinMin(26).forMin(3)
				domoticz.log('Lamp boven TV aangezet met random timer ivm inbraakpreventie', domoticz.LOG_INFO)
			end
			if (domoticz.devices('Schemerlamp bank').state == 'Off') then
				domoticz.devices('Schemerlamp bank').switchOn().withinMin(25).forMin(4)
				domoticz.log('Schemerlamp bank aangezet met random timer ivm inbraakpreventie', domoticz.LOG_INFO)
			end
			if (domoticz.devices('Yeelight eetkamer 1').state == 'Off') then
				domoticz.devices('White Temp Yeelight eetkamer 1').dimTo(20)
				domoticz.devices('Yeelight eetkamer 1').switchOn().withinMin(24).forMin(5)
				domoticz.devices('White Temp Yeelight eetkamer 2').dimTo(20)
				domoticz.devices('Yeelight eetkamer 2').switchOn().withinMin(24).forMin(5)
				domoticz.log('Lamp bank aangezet met random timer ivm inbraakpreventie', domoticz.LOG_INFO)
			end
			
			
			
			if (domoticz.devices('Schemerlamp deur').state == 'Off') then
				domoticz.devices('Schemerlamp deur').switchOn().withinMin(23).forMin(6)
				domoticz.log('Schemerlamp deur aangezet met random timer ivm inbraakpreventie', domoticz.LOG_INFO)
			end
		end
	end
}
