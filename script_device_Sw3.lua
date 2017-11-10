return {
	active = true, -- set to false to disable this script
	on = {
		devices = {
			'Sw3'
		},
	},

	execute = function(domoticz, device)
			domoticz.helpers.gotosleep(domoticz)
	end
}
