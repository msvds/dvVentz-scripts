return {
	logging = {marker = "ToonSetPoint"},
	on = {
		devices = {
			'Toon Thermostat'
		}
	},
	execute = function(domoticz, device)
		domoticz.openURL(string.format('http://%s/happ_thermstat?action=setSetpoint&Setpoint=%s', domoticz.variables('UV_ToonIP').value, device.SetPoint*100))
				domoticz.log('Setting Toon setpoint to '.. device.SetPoint,domoticz.LOG_INFO)
	end
}
