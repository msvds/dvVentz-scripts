-- smoke alarm checks and notifications are set here
return {
	active = true, -- set to false to disable this script
	on = {
		devices = {129}
    },
    execute = function(domoticz, SmokeAlarm)
        if (SmokeAlarm.state == 'On') then
			--domoticz.devices(27).state == 'Accident tone'
			domoticz.notify('Brand!', "De rookmelder in de hal boven gaat af" ,domoticz.PRIORITY_HIGH)  
        end
	end
}

