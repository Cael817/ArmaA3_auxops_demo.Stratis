// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name: auxops_vos_fnc_breakLock.sqf
//	@file Author: Cael817
//	@file Credits: MercyfulFate, heal.sqf; LouDnl, soundpathing for custom sounds
//	@file Info:

#define DURATION 120
#define ANIMATION "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_TO_FAR "You are to far away!"
#define ERR_IN_VEHICLE "You cannot do this in a vehicle!"
#define ERR_MISSING_ITEM "You dont have the neccesary item for this!"
#define ERR_TARGET_DEAD "Vehicle got destroyed!!"
#define SOUND "A3\sounds_f\weapons\horns\truck_horn_2.wss"
#define TARGET (nearestObjects [player, ["Air", "Ship", "LandVehicle"], 7] select 0)

private ["_checks", "_success"];

_break = floor (random 100);
_chance = 25;

if (_break < _chance) exitWith {
	hint "Your toolKit broke";
	player removeItem "ToolKit";
};


_checks = {
	private ["_progress","_failed", "_text"];
	_progress = _this select 0;
	_text = "";
	_failed = true;
	_displayName = getText (configFile >> "CfgVehicles" >> (typeof TARGET) >> "displayName");
	switch (true) do
	{
		case (!alive player): {}; // player is dead, no need for a notification
		case (vehicle player != player): { _text = ERR_IN_VEHICLE};
		case (!alive TARGET): { _text = ERR_TARGET_DEAD};
		case ((player distance TARGET) > 7): { _text = ERR_TO_FAR};
		case ({_x in ["ToolKit"]} count items player <= 0): { _text = ERR_MISSING_ITEM};

		default
		{
			_text = format["Breaking in to %3 %1%2", round(100 * _progress), "%", _displayName];			
			_failed = false;			
		};
	};
	[_failed, _text];
};

[] spawn {

for "_i" from DURATION to 0 step -1 do
	{
		player action ["lightOn", TARGET];
		playSound3D [SOUND, TARGET];
		//Cael817, comment the line above and uncomment the 3 lines below if you want to use custom sounds
/* 		_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
		_soundToPlay = _soundPath + "addons\auxops\common\sounds\carhorn.ogg";
		playSound3D [_soundToPlay, TARGET, false, getPosASL TARGET, 1, 1, 0]; */
		sleep 0.5;
		player action ["lightOff", TARGET];
		sleep 0.5;
		
		if (!alive player or player distance TARGET > 5 or vehicle player != player or !alive TARGET or !auxops_actions_mutex) then
		{
		breakOut "_i";
		};
	};

};

_success = [DURATION, ANIMATION, _checks, []] call auxops_actions_start;

if (_success) then {

		["You broke in to the vehicle!", 5] call auxops_notify_client;
		if (local TARGET) then
		{
			TARGET lock 1;
						//Cael817, need to a sound here
			//hint "local";
		}
		else
		{
			if ( ["A3W", briefingName, true] call BIS_fnc_inString) then{  //Cael817, added this for the fun of it, i know i could just have renamed the function or added an exception
			[[netId TARGET, 2], "A3W_fnc_setLockState", TARGET] call A3W_fnc_MP; // Lock
			//Cael817, need to a sound here
			//hint "A3W found in briefingname and not local";
			}
			else
			{
			[[netId TARGET, 1], "auxops_fnc_setLockState", TARGET] call BIS_fnc_MP; // Unlock
			//Cael817, need to a sound here
			//hint "not local";
		};
	};
};
_success;

