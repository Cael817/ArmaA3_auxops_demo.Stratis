// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name: auxops.sqf
//	@file Author: Cael817
//	@file Credits: Micovery, who made all of logistics in this script.
//	@file Info: In this file we add all the player actions and do most of the checks.

if (!isNil "auxops_functions_defined") exitWith {};
diag_log format["Loading AUXOPS functions ..."];

#define isClient !(isServer) || {isServer && !(isDedicated)}
#define LandActDist 5
#define SeaActDist 7

#include "common\keypad\auxops_fnc_keyPad.sqf"

#include "vos\auxops_vos_fnc_camonet.sqf"
#include "vos\auxops_vos_fnc_locks.sqf"

#include "bos\auxops_bos_fnc_lockDown.sqf"
#include "bos\auxops_bos_fnc_lights_perimeter.sqf"
#include "bos\auxops_bos_fnc_nearby_baselockers.sqf"

"auxops_pvar_switchMoveGlobal" addPublicVariableEventHandler { ((_this select 1) select 0) switchMove ((_this select 1) select 1) };
auxops_actions_mutex = false;


auxops_fnc_setLockState = { (objectFromNetId (_this select 0)) lock (_this select 1) } call auxops_compile; //Cael817, copy of A3W_fnc_setLockState by AgentRev.
A3W_fnc_setLockState = { (objectFromNetId (_this select 0)) lock (_this select 1) } call auxops_compile; //Cael817, this is borrowed from A3W for some testing in vos/auxops_vos_fnc_locks.sqf

auxops_switchMoveGlobal = "addons\auxops\common\switchMoveGlobal.sqf" call auxops_compile;
auxops_actions_start = "addons\auxops\common\startAction.sqf" call auxops_compile;
auxops_notify_client = "addons\auxops\common\notifyClient.sqf" call auxops_compile;

auxops_bos_fnc_check_info = "addons\auxops\bos\auxops_bos_fnc_checkinfo.sqf" call auxops_compile;
auxops_bos_fnc_select_menu = "addons\auxops\bos\auxops_bos_fnc_selectmenu.sqf" call auxops_compile;
auxops_bos_fnc_hack_base = "addons\auxops\bos\auxops_bos_fnc_hackbase.sqf" call auxops_compile;
auxops_bos_fnc_re_lock = "addons\auxops\bos\auxops_bos_fnc_reLock.sqf" call auxops_compile;

auxops_vos_fnc_check_info = "addons\auxops\vos\auxops_vos_fnc_checkinfo.sqf" call auxops_compile;
auxops_vos_fnc_select_menu = "addons\auxops\vos\auxops_vos_fnc_selectmenu.sqf" call auxops_compile;
auxops_vos_fnc_breaklock_vehicle = "addons\auxops\vos\auxops_vos_fnc_breaklock.sqf" call auxops_compile;

auxops_misc_fnc_mark_owned = "addons\auxops\misc\auxops_misc_fnc_markOwned.sqf" call auxops_compile;
auxops_misc_fnc_heal_self = "addons\auxops\misc\auxops_misc_fnc_healSelf.sqf" call auxops_compile;
auxops_misc_fnc_gut_creature = "addons\auxops\misc\auxops_misc_fnc_gutAnimal.sqf" call auxops_compile;
auxops_misc_fnc_gut_man = "addons\auxops\misc\auxops_misc_fnc_gutMan.sqf" call auxops_compile;

//Cael817, Test
auxops_check_something_false = { false };
auxops_check_something_true = { true };
auxops_works_hint = { hint "It Works!" };
//Test, End


auxops_check_is_object = {
	({cursortarget iskindof _x } count ["Land_Device_assembled_F", "Land_Portable_generator_F"] > 0);
};

auxops_check_is_baselocker = {
	({cursortarget iskindof _x } count ["Land_Device_assembled_F", "Land_Portable_generator_F"] > 0);
};

auxops_check_is_owned_baselocker =
{
	call auxops_check_is_baselocker && !isnil {cursortarget getvariable "owneruid"};
};

auxops_check_is_owner_baselocker =
{
	call auxops_check_is_baselocker && cursortarget getvariable ["ownerUID",""] == getPlayerUID player;
};

auxops_check_isnot_owner_baselocker =
{
	call auxops_check_is_baselocker && cursortarget getvariable ["ownerUID",""] != getPlayerUID player;
};

auxops_check_is_locked_baselocker =
{
	call auxops_check_is_baselocker && cursortarget getvariable ["objectLocked",false];
};

auxops_check_is_vehicle = {
	({cursortarget iskindof _x } count ["landvehicle", "ship", "air"] > 0);
};

auxops_check_is_owned_vehicle =
{
	call auxops_check_is_vehicle && !isnil {cursortarget getvariable "owneruid"};
};

auxops_check_isnot_owner_vehicle =
{
	call auxops_check_is_vehicle && cursortarget getvariable ["ownerUID",""] != getPlayerUID player;
};

auxops_check_is_owner_vehicle =
{
	call auxops_check_is_vehicle && cursortarget getvariable ["ownerUID",""] == getPlayerUID player;
};

auxops_check_unlocked_vehicle =
{
	call auxops_check_is_vehicle && {locked cursortarget < 2};
};

auxops_check_locked_vehicle =
{
	call auxops_check_is_vehicle && {locked cursortarget >= 2};
};

auxops_check_is_in_locked_vehicle =
{
	((vehicle player != player) && {locked vehicle player >= 2});
};

auxops_check_is_in_unlocked_vehicle =
{
	((vehicle player != player) && {locked vehicle player < 2});
};

auxops_check_is_commander =
{
	(vehicle player != player && commander vehicle player == player);
};

auxops_check_is_driver =
{
	(vehicle player != player && driver vehicle player == player);
};

auxops_check_is_gunner =
{
	(vehicle player != player && gunner vehicle player == player);
};

auxops_check_is_creature =
{
	count (player nearEntities [["Rabbit_F", "Snake_Random_F"], 5]) > 0;
};

auxops_check_is_man =  //Cael817, is man and alive
{
	 (!isNull cursorTarget && cursorTarget isKindOf "Man" && alive cursorTarget && player distance cursorTarget < 3);
};

auxops_check_have_gps = //Cael817, GPS or item with similiar functions ;-)
{
	({_x in ["ItemGPS", "B_UavTerminal", "O_UavTerminal", "I_UavTerminal"]} count assignedItems player > 0);
};

auxops_check_have_toolkit = 
{
	({_x in ["ToolKit"]} count items player > 0);
};

auxops_check_have_medikit =
{
	({_x in ["Medikit"]} count items player > 0);
};

auxops_check_have_fak =
{
	({_x in ["FirstAidKit"]} count items player > 0);
};

auxops_check_can_heal_self =
{
	call auxops_check_have_fak && ((damage player)>0.01 && (damage player)<0.25499);
};

auxops_check_have_explosive =
{
	({_x in ["DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag"]} count magazines player > 0);

};

auxops_cameraDir = {
  ([(positionCameraToWorld [0,0,0]), (positionCameraToWorld [0,0,LandActDist])] call BIS_fnc_vectorDiff)
};
//Cael817, this finds the object that we are suppose to manipulate, note the "surfaceIsWater", this is because with lineIntersectsWith and water using cursorTarget instead thus the activation distance needs to be a bit further.
auxops_check_is_player_near = {
	private["_objects", "_pos1", "_pos2", "_target", "_objects"];
	
	if (surfaceIsWater (position _player)) then {
		_target = false;
		_tgt = cursorTarget;
			if (!isNull cursorTarget && _player distance cursorTarget < SeaActDist) then {
			_target = true;
		};
		
		}else{ 
		_pos1 = (eyePos player);
		_pos2 = ([_pos1, call auxops_cameraDir] call BIS_fnc_vectorAdd);
		//_objects = lineIntersectsWithObjs [_pos1,_pos2,objNull,objNull,true, 2]; //Cael817, wanna try this instead of the "surfaceIsWater" workaround when i get to it....., didnt work but lets try lineIntersectsSurfaces when its out, 1.50?
		_objects = lineIntersectsWith [_pos1,_pos2,objNull,objNull,true];
		if (isNil "_objects" || {typeName _objects != typeName []}) exitWith {false};

		_target = false;

	{

		if (!isNull _x) then {
			_target = true;
			};
		} forEach _objects;
};
	(_target)
};


auxops_outside_actions = [];

auxops_remove_outside_actions = {
	if (count auxops_outside_actions == 0) exitWith {};

	{
		private["_action_id"];
		_action_id = _x;
		player removeAction _action_id;
	} forEach auxops_outside_actions;
	auxops_outside_actions = [];
};

auxops_add_outside_actions = {
	if (count auxops_outside_actions > 0) exitWith {};
	private["_player","_action_id", "_text"];
	_player = _this select 0;

	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Outside Vehicle Test Function 1", {call auxops_works_hint}, [],1,false,false,"","call auxops_check_is_vehicle && !auxops_actions_mutex"];
	auxops_outside_actions = auxops_outside_actions + [_action_id];

	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Check Vehicle Info", {call auxops_vos_fnc_check_info}, [],1,false,false,"","call auxops_check_is_vehicle && !auxops_actions_mutex"];
	auxops_outside_actions = auxops_outside_actions + [_action_id];

	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Open Vehicle User Menu", {call auxops_vos_fnc_select_menu}, [],1,false,false,"","call auxops_check_is_owned_vehicle && auxops_check_isnot_owner_vehicle && !auxops_actions_mutex"];
	auxops_outside_actions = auxops_outside_actions + [_action_id];
	
	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Open Vehicle Owner Menu", {call auxops_vos_fnc_select_menu}, [],1,false,false,"","call auxops_check_is_owned_vehicle && auxops_check_is_owner_vehicle && !auxops_actions_mutex"];
	auxops_outside_actions = auxops_outside_actions + [_action_id];
	
	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Lock Vehicle", {call auxops_vos_fnc_lock_vehicle}, [],1,false,false,"", "call auxops_check_unlocked_vehicle && auxops_check_is_owner_vehicle && !auxops_actions_mutex"];
	auxops_outside_actions = auxops_outside_actions + [_action_id];
	
	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Unlock Vehicle", {call auxops_vos_fnc_unlock_vehicle}, [],1,false,false,"", "call auxops_check_locked_vehicle && auxops_check_is_owner_vehicle && !auxops_actions_mutex"];
	auxops_outside_actions = auxops_outside_actions + [_action_id];
	
	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Break in and hotwire", {call auxops_vos_fnc_breaklock_vehicle}, [],1,false,false,"", "call auxops_check_locked_vehicle && auxops_check_isnot_owner_vehicle && auxops_check_have_toolkit && !auxops_actions_mutex"];
	auxops_outside_actions = auxops_outside_actions + [_action_id];

	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Open Base User Menu", {call auxops_bos_fnc_select_menu}, [],1,false,false,"","call auxops_check_is_owned_baselocker && auxops_check_isnot_owner_baselocker && auxops_check_is_locked_baselocker && !auxops_actions_mutex"];
	auxops_outside_actions = auxops_outside_actions + [_action_id];
	
	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Hack Base", {call auxops_bos_fnc_hack_base}, [],1,false,false,"","call auxops_check_is_owned_baselocker && auxops_check_isnot_owner_baselocker && !auxops_actions_mutex"];
	auxops_outside_actions = auxops_outside_actions + [_action_id];

	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Open Base Owner Menu", {call auxops_bos_fnc_select_menu}, [],1,false,false,"","call auxops_check_is_owned_baselocker && auxops_check_is_owner_baselocker && auxops_check_is_locked_baselocker && !auxops_actions_mutex"];
	auxops_outside_actions = auxops_outside_actions + [_action_id];

	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Check Object Info", {call auxops_bos_fnc_check_info}, [],1,false,false,"","call auxops_check_is_object && !auxops_actions_mutex"];
	auxops_outside_actions = auxops_outside_actions + [_action_id];

};


auxops_inside_actions = [];

auxops_remove_inside_actions = {
	if (count auxops_inside_actions == 0) exitWith {};

	{
		private["_action_id"];
		_action_id = _x;
		player removeAction _action_id;
	} forEach auxops_inside_actions;
	auxops_inside_actions = [];
};

auxops_add_inside_actions = {
	if (count auxops_inside_actions > 0) exitWith {};
	private["_player","_action_id", "_text"];
	_player = _this select 0;

	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Inside Vehicle Test Function 1", {call auxops_works_hint}, [],1,false,false,"","call auxops_check_something_true && !auxops_actions_mutex"];
	auxops_inside_actions = auxops_inside_actions + [_action_id];

	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "I am now a driver", {call auxops_works_hint}, [],1,false,false,"","call auxops_check_is_driver && !auxops_actions_mutex"];
	auxops_inside_actions = auxops_inside_actions + [_action_id];

	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Lock Vehicle From Inside", {call auxops_vos_fnc_lock_vehicle}, [],1,false,false,"","call auxops_check_is_in_unlocked_vehicle && !auxops_actions_mutex"];
	auxops_inside_actions = auxops_inside_actions + [_action_id];

	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Unlock Vehicle From Inside", {call auxops_vos_fnc_unlock_vehicle}, [],1,false,false,"","call auxops_check_is_in_locked_vehicle && !auxops_actions_mutex"];
	auxops_inside_actions = auxops_inside_actions + [_action_id];

};


auxops_misc_actions = [];

auxops_remove_misc_actions = {
	if (count auxops_misc_actions == 0) exitWith {};

	{
		private["_action_id"];
		_action_id = _x;
		player removeAction _action_id;
	} forEach auxops_misc_actions;
	auxops_misc_actions = [];
};

auxops_add_misc_actions = {
	if (count auxops_misc_actions > 0) exitWith {};
	private["_player","_action_id", "_text"];
	_player = _this select 0;
	
	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Misc Test Function 1", {call auxops_works_hint}, [],1,false,false,"","call auxops_check_something_true && !auxops_actions_mutex"];
	auxops_misc_actions = auxops_misc_actions + [_action_id];
	
	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Kill And Gut Animal", {call auxops_misc_fnc_gut_creature}, [],1,false,false,"","call auxops_check_is_creature && !auxops_actions_mutex"];
	auxops_misc_actions = auxops_misc_actions + [_action_id];
	
	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Kill and gut dude", {call auxops_misc_fnc_gut_man}, [],1,false,false,"","call auxops_check_is_man && !auxops_actions_mutex"];
	auxops_misc_actions = auxops_misc_actions + [_action_id];
	
	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Mark my stuff", {call auxops_misc_fnc_mark_owned}, [],1,false,false,"","call auxops_check_have_gps && !auxops_actions_mutex"];
	auxops_misc_actions = auxops_misc_actions + [_action_id];
	
	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Heal Self", {call auxops_misc_fnc_heal_self}, [],1,false,false,"","call auxops_check_can_heal_self && !auxops_actions_mutex"];
	auxops_misc_actions = auxops_misc_actions + [_action_id];
	
	_action_id = _player addAction ["<img image='addons\auxops\common\icons\bulb.paa'/> <t color=""#fd3d00"">" + "Cancel", {auxops_actions_mutex = true;}, [],1,false,false,"","auxops_actions_mutex"];
	auxops_misc_actions = auxops_misc_actions + [_action_id];

};

//Cael817, Actions that are available if outside and looking on an object.
auxops_check_outside_actions = {
	
	private["_player"];
	_player = player;
	private["_vehicle", "_in_vehicle"];
	_vehicle = (vehicle _player);
	_in_vehicle = (_vehicle != _player);

	if (!(_in_vehicle || {!(alive _player) || {!(call auxops_check_is_player_near)}}) && !auxops_actions_mutex) exitWith {
		[_player] call auxops_add_outside_actions;
	};

	[_player] call auxops_remove_outside_actions;
};

//Cael817, Actions that are available if inside a vehicle.
auxops_check_inside_actions = {
	
	private["_player","_vehicle", "_in_vehicle"];
	_player = player;
	_vehicle = (vehicle _player);
	_in_vehicle = (_vehicle != _player);

	if (_in_vehicle && alive _player && !auxops_actions_mutex) exitWith {
		[_player] call auxops_add_inside_actions;
	};

	[_player] call auxops_remove_inside_actions;
};

//Cael817, Actions that are available at any time except when dead or doing something else)
auxops_check_misc_actions = {
	private["_player"];
	_player = player;
	
	if (alive _player && !auxops_actions_mutex) exitWith {
		[_player] call auxops_add_misc_actions;
	};

	[_player] call auxops_remove_misc_actions;
};


auxops_client_loop_stop = false;
auxops_client_loop = {
  if (!(isClient)) exitWith {};
	private ["_auxops_client_loop_i"];
	_auxops_client_loop_i = 0;

	while {_auxops_client_loop_i < 5000 && !(auxops_client_loop_stop)} do {
		call auxops_check_outside_actions;
		call auxops_check_inside_actions;
		call auxops_check_misc_actions;
		sleep 0.5;
		_auxops_client_loop_i = _auxops_client_loop_i + 1;
	};
	[] spawn auxops_client_loop;
};

[] spawn auxops_client_loop;

auxops_functions_defined = true;
diag_log format["Loading AUXOPS functions complete"];
systemChat "Loading AUXOPS functions complete";
