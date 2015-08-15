// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: compile.sqf
//	@file Author: AgentRev, MercyfulFate
//	@file Credits:
//	@file Info:

// Compile a function from a file.
// if in debug mode, the function will be dyncamically compiled every call.
// if not in debug mode, the function will be compileFinal'd
// example: my_fnc_name = ["path/to/folder", "my_fnc.sqf"] call auxops_compile;
// example: my_fnc_name = ["path/to/folder/my_fnc.sqf"] call auxops_compile;
// later in the code you can simply use call my_fnc_name;
// you can also pass raw code to get it compileFinal'd
// example: my_fnc_name = {diag_log "hey"} call auxops_compile;
auxops_compile = compileFinal
('
	private ["_path", "_isDebug", "_code"];
	_path = "";
	_isDebug = true;

	switch (toUpper typeName _this) do {
		case "STRING": {
			_path = _this;
		};
		case "ARRAY": {
			_path = format["%1\%2", _this select 0, _this select 1];
		};
		case "CODE": {
			_code = toArray str _this;
			_code set [0, (toArray " ") select 0];
			_code set [count _code - 1, (toArray " ") select 0];
		};
	};

	if (isNil "_code") then {
		if (_isDebug) then {
			compile format ["call compile preProcessFileLineNumbers ""%1""", _path]
		} else {
			compileFinal preProcessFileLineNumbers _path
		};
	} else {
		if (_isDebug) then {
			compile toString _code
		} else {
			compileFinal toString _code
		};
	};
');