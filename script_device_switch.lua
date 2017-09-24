return {
	active = true,
	on = {
		devices = {
			'Test Switch'
		}
	},

	execute = function(domoticz, mySwitch)
		if (mySwitch.state == 'On') then
			--domoticz.notify('Hey!', 'I am on!', domoticz.PRIORITY_NORMAL)
			domoticz.log('Hey! I am on!')
		end
	end
}
