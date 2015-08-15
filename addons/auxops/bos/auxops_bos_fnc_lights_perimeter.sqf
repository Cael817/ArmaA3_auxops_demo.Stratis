// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name: auxops_bos_fnc_lights_perimeter.sqf
//	@file Author: Cael817
//	@file Credits:
//	@file Info:



auxops_bos_fnc_lights_perimeter = {
#define RADIUS 34 
#define AMOUNT 8

_centerObject = cursorTarget;
_centerObject_pos = getPos _centerObject;
_lightObject = "Land_LampHarbour_F";

if (_centerObject getvariable "basehaslight") exitWith {hint "Base already has lights"};
		_inc = 360/AMOUNT; 
		for "_ang" from 0 to 359 step _inc do {
		_a = (_centerObject_pos select 0)+(sin(_ang)*RADIUS);
		_b = (_centerObject_pos select 1)+(cos(_ang)*RADIUS);
		_pos = [_a,_b,_centerObject_pos select 2];
		_object = createVehicle [_lightObject, _pos, [], 0, "CAN_COLLIDE"];
		_object setDir _ang;
		_object setVariable ["allowDamage", true, true];
		_object setVariable ["objectLocked",true,true];
		_object setVariable ["R3F_LOG_disabled", false, true];
		_object setVariable ["R3F_Side", (playerSide), true];
		_object setVariable ["ownerUID", getPlayerUID player, true];
		_object setVariable ["ownerName", name player, true];
		pvar_manualObjectSave = netId _object;
		publicVariableServer "pvar_manualObjectSave";
		_centerObject setVariable ["basehaslight", true, true]; //For the future
	};
	[format ["Added basic lighting around the base radius of (%1m)",RADIUS], 5] call mf_notify_client;
};
