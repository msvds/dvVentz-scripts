return {
	active = true,
	logging = {
		level = domoticz.LOG_INFO,
		marker = "TEST"
	},
	on = {
		devices = {
			91
		},
	},
	execute = function(domoticz, device)
		--domoticz.devices('Xiaomi Gateway Doorbell').level == 10
		domoticz.devices('Xiaomi Gateway Volume').level == 10
		domoticz.devices('Xiaomi Gateway Doorbell').switchOn()
		--domoticz.log(domoticz.devices('Gashaard').state)
		--domoticz.devices('Gashaard').setState('Run Down')		
		--domoticz.log(domoticz.devices('Gashaard').state)
		--domoticz.devices('Xiaomi Gateway Alarm Ringtone').switchOn()
		--debug = true
		--local currentSetpoint = domoticz.helpers.currentSetpoint(domoticz)
		--domoticz.log('Huidige setpoint is '.. currentSetpoint)
		--local currentTemperature = domoticz.helpers.currentTemperature(domoticz)
		--domoticz.log('Huidige temp is '.. currentTemperature)		
		--local currentProgramState = domoticz.helpers.currentProgramState(domoticz)
		--domoticz.log('Huidige prog is '.. currentProgramState)		
		--local currentActiveState = domoticz.helpers.currentActiveState(domoticz)
		--domoticz.log('Huidige active state is '.. currentActiveState)
		--domoticz.log('Testswitch', domoticz.LOG_INFO)
		--local testswitch = domoticz.devices(91)
		--local Status_selector = domoticz.devices(90)
		--domoticz.log(Status_selector.state)
		--Status_selector.switchSelector(20)
		--local dimmer_bed_martijn = domoticz.devices(149)		
		--local dimmer_bed_suzanne = domoticz.devices(150)
		--if (domoticz.time.matchesRule('at 16:00-00:30')) then --and Slaapkdeur.state == 'Open'
		--	if (dimmer_bed_martijn.state == 'Off') then
		--		dimmer_bed_martijn.dimTo(20)
		--		--dimmer_bed_martijn.switchOn()
		--		domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Martijn aangezet', domoticz.LOG_INFO)
		--	end
		--	if (dimmer_bed_suzanne.state == 'Off') then
		--		dimmer_bed_suzanne.dimTo(20)
		--		--dimmer_bed_suzanne.switchOn()
		--		domoticz.log('Slaapkamerdeur open terwijl het donker is, Nachtlampje Suzanne aangezet', domoticz.LOG_INFO)
		--	end
		--e--n-d
	end
}
