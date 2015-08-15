// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name:
//	@file Author: Cael817
//	@file Credits:
//	@file Info:

class auxops_keypad
{
	idd=-1;
	movingenable=false;
	class controls 
	{
		class kp_RscBackground: auxops_RscBackground
		{
			idc = 2200;
			x = 0.3;
			y = 0.04;
			w = 0.4;
			h = 0.76;
		};
		class kp_RscText: auxops_RscText
		{
			idc = 1000;
			text = "Enter PIN";
			x = 0.325;
			y = 0.08;
			w = 0.35;
			h = 0.16;
		};
		class kp_RscFrame1: auxops_RscFrame
		{
			idc = 1800;
			x = 0.325;
			y = 0.08;
			w = 0.35;
			h = 0.16;
		};
		class kp_RscFrame2: auxops_RscFrame
		{
			idc = 1800;
			x = 0.3;
			y = 0.04;
			w = 0.4;
			h = 0.76;
		};
		class kp_key_1: auxops_RscButton
		{
			idc = 1600;
			text = "1";
			x = 0.325;
			y = 0.28;
			w = 0.1;
			h = 0.1;
			Action = "[""number"", 1]call auxops_fnc_press_buttons";
		};
		class kp_key_2: auxops_RscButton
		{
			idc = 1601;
			text = "2";
			x = 0.45;
			y = 0.28;
			w = 0.1;
			h = 0.1;
			Action = "[""number"", 2]call auxops_fnc_press_buttons";
		};
		class kp_key_3: auxops_RscButton
		{
			idc = 1602;
			text = "3";
			x = 0.575;
			y = 0.28;
			w = 0.1;
			h = 0.1;
			Action = "[""number"", 3]call auxops_fnc_press_buttons";
		};
		class kp_key_4: auxops_RscButton
		{
			idc = 1603;
			text = "4";
			x = 0.325;
			y = 0.4;
			w = 0.1;
			h = 0.1;
			Action = "[""number"", 4]call auxops_fnc_press_buttons";
		};
		class kp_key_5: auxops_RscButton
		{
			idc = 1604;
			text = "5";
			x = 0.45;
			y = 0.4;
			w = 0.1;
			h = 0.1;
			Action = "[""number"", 5]call auxops_fnc_press_buttons";
		};
		class kp_key_6: auxops_RscButton
		{
			idc = 1605;
			text = "6";
			x = 0.575;
			y = 0.4;
			w = 0.1;
			h = 0.1;
			Action = "[""number"", 6]call auxops_fnc_press_buttons";
		};
		class kp_key_7: auxops_RscButton
		{
			idc = 1606;
			text = "7";
			x = 0.325;
			y = 0.52;
			w = 0.1;
			h = 0.1;
			Action = "[""number"", 7]call auxops_fnc_press_buttons";
		};
		class kp_key_8: auxops_RscButton
		{
			idc = 1607;
			text = "8";
			x = 0.45;
			y = 0.52;
			w = 0.1;
			h = 0.1;
			Action = "[""number"", 8]call auxops_fnc_press_buttons";
		};
		class kp_key_9: auxops_RscButton
		{
			idc = 1608;
			text = "9";
			x = 0.575;
			y = 0.52;
			w = 0.1;
			h = 0.1;
			Action = "[""number"", 9]call auxops_fnc_press_buttons";
		};
		class kp_key_clear: auxops_RscButton
		{
			idc = 1609;
			text = "Clear";
			x = 0.325;
			y = 0.64;
			w = 0.1;
			h = 0.1;
			Action = "[""clear"", 0]call auxops_fnc_press_buttons";
		};
		class kp_key_0: auxops_RscButton
		{
			idc = 1610;
			text = "0";
			x = 0.45;
			y = 0.64;
			w = 0.1;
			h = 0.1;
			Action = "[""number"", 0]call auxops_fnc_press_buttons";
		};
		class kp_key_enter: auxops_RscButton
		{
			idc = 1611;
			text = "Enter";
			x = 0.575;
			y = 0.64;
			w = 0.1;
			h = 0.1;
			Action = "[""enter"", 0]call auxops_fnc_press_buttons";
		};
	};
};	
