// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: auxops_bos_fnc_hackBase.sqf
//	@file Author: Cael817
//	@file Created: MerciFulfate based on heal.sqf, LouDnl based on hackBase.sqf
//	@file Description:

#define DURATION 30
#define ANIMATION "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_CANCELLED "Hacking Canceled!"
#define ERR_TO_FAR "You are to far away!"
#define ERR_IN_VEHICLE "You cannot do this in a vehicle!"

private ["_checks", "_success"];

_checks = {
	private ["_progress","_failed", "_text"];
	_progress = _this select 0;
	_text = "";
	_failed = true;
	switch (true) do
	{	
		case (!alive player): {}; // player is dead, no need for a notification
		case (vehicle player != player): { _text = ERR_IN_VEHICLE};
		case ((player distance cursorTarget) > 5): { _text = ERR_TO_FAR};

		default
		{
			_text = format ["Hacking base %1%2 complete", floor (_progress * 100), "%"];
			_failed = false;
		};
	};	
	[_failed, _text];
};

_success = [DURATION, ANIMATION, _checks, [cursorTarget]] call auxops_actions_start;

if (_success) then {
	cursorTarget setVariable ["lockDown", false, true];
	cursorTarget setVariable ["password", "0000", true];
	["Base Lock is hacked, the Lock Down is removed and the pin is set to 0000", 5] call auxops_notify_client;
};
_success;