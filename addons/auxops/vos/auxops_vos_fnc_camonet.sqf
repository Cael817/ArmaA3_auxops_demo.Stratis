// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name: auxops_vos_fnc_camonet.sqf
//	@file Author: Cael817
//	@file Credits:
//	@file Info: Just for fun, need alot of stuff to work properly

auxops_vos_fnc_camonet ={
	camonet_deployed = false;
	[] spawn {
			
			[] call {
			if (auxops_actions_mutex) exitwith { hint "You are already doing something";};
			_vehicle = cursorTarget;
			if !(_vehicle getVariable ["camonet_deployed", false] ) then {

				auxops_actions_mutex = true;
				
				["Deploying Camo Net!", 5] call auxops_notify_client;
				_vehicle setvariable ["camonet_deployed",true,true];
				_camonet = createVehicle ["CamoNet_INDP_big_F", (_vehicle modelToWorld [0,0,0]), [], 0, "NONE"];				
				_camonet setDir ((direction _vehicle) -180);
				_camonet setPos (_vehicle modelToWorld [0,0,-1.3]);
			
			}else{
				_net = objNull;
				_vehicle = cursorTarget;				
				_vehicle setvariable ["deployed",false,true];
				_camonet = nearestObjects [_vehicle, ["CamoNet_INDP_big_F"], 3];
				if (count _camonet > 0) then {
				_net = _camonet select 0;
				};
				_net;
				["Packing Camo Net!", 5] call auxops_notify_client;
				deleteVehicle _net;
				_vehicle setvariable ["camonet_deployed",false,true];
			};
			auxops_actions_mutex = false;
		};
	};
};
