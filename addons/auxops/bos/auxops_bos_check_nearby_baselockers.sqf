// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name: auxops_bos_dlg_userMenu.hpp
//	@file Author: Apoc, Cael817
//	@file Credits: Raymix, from Plot4Life
//	@file Info: Checks for nearby baselockers and disallowns locking in R3F with the appropriate calls

auxops_bos_check_nearby_baselockers = {
	//Function taken from Epoch, specifically Plot4Life by Raymix.  Integration by Apoc
	private ["_findNearestBLs","_findNearestBL","_distance","_nearestBL","_ownerUID", "_isNearBL"];
	
	_allowR3FLock = false;
	_distance = 75;

	_findNearestBLs = nearestObjects [player, ["Land_Device_assembled_F"], _distance];
	_findNearestBL  = [];

	{
		if ((alive _x) && (_x getVariable ["objectLocked",false])) then {
			_findNearestBL set [(count _findNearestBL), _x];
		};
	} count _findNearestBLs;
	
	_isNearBL = count (_findNearestBL);
	
if (_isNearBL == 0) then {
	_allowR3FLock = true;
		} else {
			_nearestBL = _findNearestBL select 0; //nearest is always first in array w/ nearestObjects
			_ownerUID = _nearestBL getVariable ["ownerUID",0];
			_lockdown = _nearestBL getVariable ["lockDown", true];
			
			if (!_lockDown or _ownerUID == getPlayerUID player) then {
				_allowR3FLock = true;
			} else {
				_allowR3FLock = false;
			};
		};
_allowR3FLock
};
