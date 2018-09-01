return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Wireless Wall Switch Hal Beneden Lampen Hal Boven'
		},
	},

	execute = function(domoticz, device)
		if domoticz.devices('Single Wall Switch Hal Boven').state == 'On' then
			domoticz.devices('Single Wall Switch Hal Boven').switchOff().checkFirst()
			domoticz.log('Lampen hal boven uitgezet',domoticz.LOG_INFO)
		elseif domoticz.devices('Single Wall Switch Hal Boven').state == 'Off' then
			domoticz.devices('Single Wall Switch Hal Boven').switchOn()	.checkFirst()
			domoticz.log('Lampen hal boven aangezet',domoticz.LOG_INFO)
		end	
	end
}
