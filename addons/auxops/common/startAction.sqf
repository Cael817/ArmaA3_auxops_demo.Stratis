// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name:
//	@file Author: A3W
//	@file Credits: A3W
//	@file Info:
#define DURATION_STEP 1
#define DURATION_FAILED 5
//TODO: Fix the jerkiness (playMove vs switchMove)
private ["_length", "_animation", "_check", "_args", "_success", "_failure", "_complete", "_start", "_previousAnim"];

if auxops_actions_mutex exitWith {
	["You're already doing something!", DURATION_FAILED] call auxops_actions_notify;
};
auxops_actions_mutex = true;

_length = _this select 0;
_animation = _this select 1;
_check = _this select 2;
_args = _this select 3;

_complete = true;
_start = time;
_previousAnim = animationState player;
[player, _animation] call auxops_switchMoveGlobal;
_failed = false;

createDialog "auxops_progress";
disableSerialization;
_display = findDisplay 81701;
_display displayAddEventHandler ["KeyDown", "_this select 1 == 1;"];
_progressbar =  _display displayCtrl 81701;
_struct_text = _display displayCtrl 81702;
waitUntil {
	private ["_progress", "_result", "_text"];
	if (animationState player != _animation) then { [player, _animation] call auxops_switchMoveGlobal };

	if not auxops_actions_mutex then {
		_failed = true;
		["Action Cancelled", DURATION_FAILED] call auxops_notify_client;
	} else {
		_progress = (time - _start)/_length;
		_progressbar progressSetPosition _progress;
		_result = ([_progress]+_args) call _check;
		_break = _result select 0;
		_text = _result select 1;
		if _break then {
			[_text, DURATION_FAILED] call auxops_notify_client;
			_failed = true;
		} else {
			_struct_text ctrlSetStructuredText parseText _text;
		};
	};
	_start +_length < time or _failed;
};
[player, _previousAnim] call auxops_switchMoveGlobal;
closeDialog 81701;
auxops_actions_mutex = false;
not _failed;
