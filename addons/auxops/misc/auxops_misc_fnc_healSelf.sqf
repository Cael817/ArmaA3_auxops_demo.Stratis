// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: healSelf.sqf
//	@file Author: MercyfulFate
//	@file Created:
//	@file Info: Heal yourself

#define DURATION 15
#define ANIMATION "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_CANCELLED "First Aid Cancelled!"
#define ERR_TO_FAR "You are to far away!"
#define ERR_IN_VEHICLE "You cannot do this in a vehicle!"

#define ERR_NOT_ENOUGH_HEALTH "First Aid Failed! You are too badly injured to use this."
#define ERR_FULL_HEALTH "First Aid Failed! You already have full health."

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
		//case ((player distance cursorTarget) > 5): { _text = ERR_TO_FAR};
		case (damage player > 0.255): {_text = ERR_NOT_ENOUGH_HEALTH};
		case (damage player < 0.005): {_text = ERR_FULL_HEALTH};

		default
		{
			_text = format["First Aid Kit %1%2 Applied", round(100 * _progress), "%"];			
			_failed = false;			
		};
	};
	[_failed, _text];
};

_success = [DURATION, ANIMATION, _checks, []] call auxops_actions_start;

if (_success) then {
	player setDamage 0;
	["First Aid Completed, you are now fully functional again!", 5] call auxops_notify_client;
};
_success;
