// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: gutAnimal.sqf
//	@file Author: Cael817 based on MercyfulFates healSelf.sqf
//	@file Created:
//	@file Info: kills and guts a creature

#define DURATION 5
#define ANIMATION "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_CANCELLED "Gutting of the creature Cancelled!"
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
		//case (player distance cursorTarget > 5): {_text = ERR_TO_FAR};
		case (vehicle player != player): { _text = ERR_IN_VEHICLE};

		default
		{
			_text = format["Aha, killed it, now gutting it %1%2", round(100 * _progress), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};

{_x setDamage 1} forEach (player nearEntities [["Rabbit_F", "Snake_Random_F"], 5]);
_success = [DURATION, ANIMATION, _checks, []] call auxops_actions_start;

if (_success) then {
	//deleteVehicle _deadAnimal; //need to find it before i can delete it.... maybe not necessary
	[MF_ITEMS_CANNED_FOOD, 1] call mf_inventory_add;
	["You killed and turned the creature into canned food. Well Done!", 5] call mf_notify_client;
};
_success;
