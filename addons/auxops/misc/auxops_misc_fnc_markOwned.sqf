// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name:
//	@file Author: Cael817
//	@file Credits:
//	@file Info:

#define OWNED_SEARCH_RADIUS 1000

_objects = nearestObjects [position player, ["Landvehicle", "Ship", "Air", "Building", "ReammoBox_F", "thingX"], OWNED_SEARCH_RADIUS];

if (isNil "ownedObjectMapMarkers") then {
	ownedObjectMapMarkers = [];
};

if (count ownedObjectMapMarkers > 0) then {

	{
		deleteMarkerLocal _x;
	} forEach ownedObjectMapMarkers;
	ownedObjectMapMarkers = [];
	["Map cleared of previous markers", 5] call mf_notify_client;
};

ownedObjectMapMarkers = [];
_relockTime = [];
_lastUsedTime = [];
{
	if(_x getVariable "ownerUID" == getplayerUID player) then
	
	{
	private ["_name","_objPos","_name","_marker"];
	_name = gettext(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName");
	_objPos = getPosATL _x;
	_relockTime = _x getVariable ["baseSaving_hoursAlive", 0];
	_lastUsedTime = _x getVariable ["vehSaving_hoursUnused", 0];
	_marker = "ownedObjectMapMarkers" + (str _forEachIndex);
	_marker = createMarkerLocal [_marker,_objPos];
	_marker setMarkerTypeLocal "waypoint";
	_marker setMarkerPosLocal _objPos;
	_marker setMarkerTextLocal _name;
	_marker setMarkerColorLocal "ColorBlue";
	_marker setMarkerSizeLocal [0.6,0.6];
	ownedObjectMapMarkers pushBack _marker;
};
} forEach _objects;

	if (count ownedObjectMapMarkers > 0) then {

		titleText ["Added Markers for your objects within 1000m on the map, they can only be seen by you and they will be removed in 30 seconds.","PLAIN DOWN"]; titleFadeOut 5;

	}else{

		titleText ["No owned objects found within 1000m!","PLAIN DOWN"]; titleFadeOut 5;

};
	
sleep 30;
	
if (count ownedObjectMapMarkers > 0) then {

	{
		deleteMarkerLocal _x;
	} forEach ownedObjectMapMarkers;
	ownedObjectMapMarkers = [];
	titleText ["Map cleared!","PLAIN DOWN"]; titleFadeOut 5;
};
