// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: init.sqf
//	@file Author: Cael817
//	@file Credits: Micovery
//	@file Info: The init for auxops, call it from the main mission init with "if (hasInterface || isServer) then { [] execVM "addons\auxops\init.sqf"; };"

call compile preprocessFileLineNumbers "addons\auxops\config.sqf";

{
  call compile preprocessFileLineNumbers format["addons\auxops\%1.sqf", _x];
} forEach ["compile", "auxops"];
