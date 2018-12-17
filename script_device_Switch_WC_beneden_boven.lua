return {
	active = true, -- set to false to disable this script
	logging = {marker = "script_device_Switch_WC_beneden_boven"},
	on = {
		devices = {
			'Wall Switch WC Beneden','Wall Switch WC Boven'
		},
	},

	execute = function(domoticz, device)
		local FAN_DEVICE = 'Centrale Afzuiging Boost' -- Fan device
		local FORCE_FAN_TIME = 5 -- Minutes to force the fan when button pushed
		domoticz.devices(FAN_DEVICE).switchOn().forMin(FORCE_FAN_TIME)
	end
}
