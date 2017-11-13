return {
	active = true, -- set to false to disable this script
	on = {
		timer = {'every 1 minutes'}
		--devices = {
		--	'Suzanne smartphone',
		--	'Martijn smartphone'
		--},
	},

	execute = function(domoticz, device)
		local movement_delay = 2
		local nomovement_delay = 5
		local open_delay = 0
		domoticz.log('domoticz.globalData.MC_Overall = ' ..domoticz.globalData.MC_Overall)
		domoticz.log('domoticz.globalData.NMC_Overall = ' ..domoticz.globalData.NMC_Overall)
		domoticz.log('domoticz.globalData.OpenC_Overall = ' ..domoticz.globalData.OpenC_Overall)
		if (domoticz.devices('SomeoneHome').state == 'Off' and (domoticz.devices('Suzanne smartphone').state == 'On' or domoticz.devices('Martijn smartphone').state == 'On') or domoticz.globalData.MC_Overall > movement_delay or domoticz.globalData.OpenC_Overall > open_delay) then
			domoticz.devices('SomeoneHome').switchOn()
		elseif (domoticz.devices('SomeoneHome').state == 'On' and (domoticz.devices('Suzanne smartphone').state == 'Off' and domoticz.devices('Martijn smartphone').state == 'Off') and domoticz.globalData.NMC_Overall > nomovement_delay) then
			domoticz.devices('SomeoneHome').switchOff()
		end
	end
}
