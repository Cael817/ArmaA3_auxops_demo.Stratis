// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name: auxops_vos_fnc_locks.sqf
//	@file Author: Cael817
//	@file Credits: LouDnl, for the soundpathing;
//	@file Info:

auxops_vos_fnc_lock_vehicle = {
	[] spawn {

		[] call {
		private ["_vehicle","_nearvehicle"];
		_nearvehicle = nearestObjects [player, ["LandVehicle", "Ship", "Air"], 7];
		_vehicle = _nearvehicle select 0;
			
			if (local _vehicle) then
					{
						_vehicle lock true;
						//(hint "local";
					}
					else
					{
						[[netId _vehicle, 2], "auxops_fnc_setLockState", _vehicle] call BIS_fnc_MP; // Lock
						//hint "not local";
					};

			//_vehicle setVariable ["objectLocked", true, true];
			_vehicle setVariable ["R3F_LOG_disabled",true,true];		
			_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
			_soundToPlay = _soundPath + "addons\AUXOPS\common\sounds\carlock.ogg";
			playSound3D [_soundToPlay, _vehicle, false, getPosASL _vehicle, 1, 1, 15];
			_vehicle engineOn false;
			player action ["lightOn", _vehicle];
			sleep 0.5;
			player action ["lightOff", _vehicle];
			titleText ["Vehicle Locked!","PLAIN DOWN"]; titleFadeOut 2;
		};
	};
};

auxops_vos_fnc_unlock_vehicle = {
	[] spawn {

		[] call {
		private ["_vehicle","_nearvehicle"];
		_nearvehicle = nearestObjects [player, ["LandVehicle", "Ship", "Air"], 7];
		_vehicle = _nearvehicle select 0;

			if (local _vehicle) then
					{
						_vehicle lock 1;
						//hint "local";
					}
					else
					{
						[[netId _vehicle, 1], "auxops_fnc_setLockState", _vehicle] call BIS_fnc_MP; // Unlock
						//hint "not local";
					};
					
			//_vehicle setVariable ["objectLocked", false, true]; 
			_vehicle setVariable ["R3F_LOG_disabled",false,true];		
			_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
			_soundToPlay = _soundPath + "addons\AUXOPS\common\sounds\carlock.ogg";
			playSound3D [_soundToPlay, _vehicle, false, getPosASL _vehicle, 1, 1, 15];
			player action ["lightOn", _vehicle];
			sleep 0.5;
			player action ["lightOff", _vehicle];
			titleText ["Vehicle Unlocked!","PLAIN DOWN"]; titleFadeOut 2;
		};
	};
};