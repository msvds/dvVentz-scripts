return {
	active = true,
	logging = {marker = "yeelight_dimmer_eetkamer_2"},
	on = {
		devices = {
			'Yeelight Dimmer eetkamer 2'
		},
	},
	execute = function(domoticz, device)
		local IP = '192.168.190.38';
		local PORT = '55443'
		if(domoticz.devices('White Temp Yeelight eetkamer 2').state=='Off') then 
			DomValue = 0;
			runcommandoff = "sudo echo -ne '{\"id\":1,\"method\":\"set_power\", \"params\":[\"off\", \"smooth\", 500]}\\r\\n' | nc -w1 " ..IP.." " ..PORT.."";;
			os.execute(runcommandoff);
		else
			TempValue = domoticz.devices('White Temp Yeelight eetkamer 2').level;
			CalcValue = ((TempValue-1) * 48)+1700;
			DomValue = domoticz.devices('Yeelight Dimmer eetkamer 2').level;
		end
		if CalcValue==nil then CalcValue=0 end

		runcommand = "sudo echo -ne '{\"id\":1, \"method\":\"set_scene\", \"params\":[\"ct\", " .. CalcValue .. ", " .. DomValue .. "]}\\r\\n' | nc -w1 " ..IP.." " ..PORT.."";
		os.execute(runcommand);
		print(runcommand)
		print("bright value= "..DomValue);
	end
}
