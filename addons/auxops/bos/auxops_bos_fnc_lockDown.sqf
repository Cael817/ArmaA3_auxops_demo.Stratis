// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name: auxops_bos_fnc_lockDown.sqf
//	@file Author: Cael817
//	@file Credits:
//	@file Info:

auxops_bos_fnc_lockdown =
{
	cursorTarget setVariable ["lockDown", true, true];
	["Base is now under Lock Down!", 5] call auxops_notify_client;
};

auxops_bos_fnc_release_lockdown =
{
	cursorTarget setVariable ["lockDown", false, true];
	["Released Lock Down!", 5] call auxops_notify_client;
};