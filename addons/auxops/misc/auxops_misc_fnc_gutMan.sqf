// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: gutMan.sqf
//	@file Author: Cael817 based on MercyfulFates healSelf.sqf
//	@file Created:
//	@file Info: kills and guts a man

#define DURATION 1
#define ANIMATION "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_CANCELLED "You cancelled the action!"
#define ERR_TO_FAR "You are to far away!"
#define ERR_IN_VEHICLE "You cannot do this in a vehicle!"

private ["_checks", "_success"];

_checks = {
	private ["_progress", "_failed", "_text"];
	_progress = _this select 0;
	_text = "";
	_failed = true;
	switch (true) do
	{
		case (!alive player): {}; // player is dead, no need for a notification
		case (vehicle player != player): { _text = ERR_IN_VEHICLE};
		case (player distance cursorTarget > 3): {_text = ERR_TO_FAR};
		case (vehicle player != player): { _text = ERR_IN_VEHICLE};

		default
		{
			_text = format["Aha, killed him, now gutting it %1%2", round(100 * _progress), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};

{_x playMove "DeadState" call auxops_switchMoveGlobal} foreach [cursortarget];
_success = [DURATION, ANIMATION, _checks, [cursorTarget]] call auxops_actions_start;

if (_success) then {
	{_x setDamage 1} foreach [cursortarget]; //kill is probably not awarded in A3W
	[MF_ITEMS_CANNED_FOOD, 2] call mf_inventory_add;
	["You killed and gutted a dude!", 5] call auxops_notify_client;
};
_success;
