// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name:
//	@file Author: Cael817
//	@file Credits: AirFell based on AF_KeyPad http://www.armaholic.com/page.php?id=26498
//	@file Info:

InputText = "";
ClearText = "Enter PIN";
OutputText = "";

auxops_fnc_press_buttons = {
	switch (_this select 0) do {
		case "number": {
			InputText = InputText + format["%1", _this select 1];
			ctrlSetText[1000, InputText];
		};
		case "clear": {
			InputText = "";
			ctrlSetText[1000, ClearText];
		};
		case "enter": {
			OutputText = InputText;
			closeDialog 0;
			InputText = "";
		};		
	};
};

auxops_vos_fnc_enter_pin = {
	[] spawn {
		_object = cursorTarget;

		OutputText = nil;

		createDialog "auxops_Keypad";

		waitUntil {!(isNil "OutputText")};

		if (OutputText == _object getVariable ["password", ""]) then {

			createDialog "auxops_vehicle_user_menu";

		}else{

			["Wrong PIN!", 5] call auxops_notify_client;
		
		};
		OutputText = nil;			
	};
};

auxops_bos_fnc_enter_pin = {
	[] spawn {
		_object = cursorTarget;

		OutputText = nil;

		createDialog "auxops_Keypad";

		waitUntil {!(isNil "OutputText")};

		if (OutputText == _object getVariable ["password", ""]) then {

			createDialog "auxops_base_user_menu";

		}else{

			["Wrong PIN!", 5] call auxops_notify_client;
		
		};
		OutputText = nil;			
	};
};

auxops_fnc_change_pin = {
	[] spawn {
		_object = cursorTarget;

		OutputText = nil;

		createDialog "auxops_keypad";

		waitUntil {!(isNil "OutputText")};

		_object setVariable ["password", OutputText, true];

		if (OutputText=="")then {

			["PIN lock disabled!", 5] call auxops_notify_client;

		}else{

			["You successfully changed the PIN!", 5] call auxops_notify_client;

		};
		OutputText = nil;
	};
};

auxops_fnc_memorize_pin = 
{
	_pin = cursorTarget getVariable "password";
	if (isNil "_pin" || {_pin ==""}) then {

		hint "PIN is not set";

	}else{

		hint format ["You memorized PIN as %1", _pin];
		player setVariable ["password",_pin, true];

	};
};