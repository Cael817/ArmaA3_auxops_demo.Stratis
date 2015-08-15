// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name: auxops_bos_fnc_selectMenu.sqf
//	@file Author: Cael817
//	@file Credits:
//	@file Info:

private ["_uid", "_haspin", "_targetpin", "_owner"];
_uid = getPlayerUID player;
_haspin = player getVariable ["password", ""];
_targetpin = cursorTarget getvariable "password";
_owner = cursorTarget getvariable "ownerUID";

//if (player getVariable ["FAR_isUnconscious", 0] == 0) exitWith {};
switch (true) do
{
	case (_uid == _owner):
	{
	
		createDialog "auxops_base_owner_menu";
		//hint "Welcome Owner";
	};
	case (_haspin == _targetpin):
	{
	
		createDialog "auxops_base_user_menu";
		//hint "Welcome User";
	};
	case (_uid != _owner):
	{
	
		call auxops_bos_fnc_enter_pin;
		//hint "Welcome";
	};
	default
	{
	hint "An unknown error occurred"
	};

};

