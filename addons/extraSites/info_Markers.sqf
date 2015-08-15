//@file Version: 1.0
//@file Name: infomarkers.sqf
//@file Author: Cael817, GID Positioning System
//@file Desc: For placing markers

//Top left corner markers
_pos = [1000,30000,0];
_object = createMarkerLocal ["Info_1", _pos];
_object setMarkerShapeLocal "ICON";
_object setMarkerTextLocal "Server address 176.10.245.30 Port 2302 ";
_object setMarkerColorLocal "ColorBlack";	
_object setMarkerTypeLocal "mil_unknown";

_pos = [1000,29750,0];
_object = createMarkerLocal ["Info_2", _pos];
_object setMarkerShapeLocal "ICON";
_object setMarkerTextLocal "TeamSpeak address 176.10.245.30";
_object setMarkerColorLocal "ColorBlack";	
_object setMarkerTypeLocal "mil_unknown";
/*
_pos = [1000,29500,0];
_object = createMarkerLocal ["Info_3", _pos];
_object setMarkerShapeLocal "ICON";
_object setMarkerTextLocal "Lorem Ipsum";
_object setMarkerColorLocal "ColorBlack";	
_object setMarkerTypeLocal "mil_unknown";

_pos = [1000,29250,0];
_object = createMarkerLocal ["Info_4", _pos];
_object setMarkerShapeLocal "ICON";
_object setMarkerTextLocal "Lorem Ipsum";
_object setMarkerColorLocal "ColorBlack";	
_object setMarkerTypeLocal "mil_unknown";

_pos = [1000,29000,0];
_object = createMarkerLocal ["Info_5", _pos];
_object setMarkerShapeLocal "ICON";
_object setMarkerTextLocal "Lorem Ipsum";
_object setMarkerColorLocal "ColorBlack";	
_object setMarkerTypeLocal "mil_unknown";
*/
//Spawn island warning
_pos = [14500,5870,0];
_object = createMarkerLocal ["Info_6", _pos];
_object setMarkerShapeLocal "ELLIPSE";
_object setMarkerTextLocal "...";
_object setMarkerColorLocal "ColorRed";	
_object setMarkerTypeLocal "mil_unknown";
_object setMarkerSize [120,120];
//Spawn island warning text and icon
_pos = [14500,5870,0];
_object = createMarkerLocal ["Info_7", _pos];
_object setMarkerShapeLocal "ICON";
_object setMarkerTextLocal "Dont go or Build here, you might get BANNED for doing so.";
_object setMarkerColorLocal "ColorBlack";	
_object setMarkerTypeLocal "mil_warning";
