// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name: auxops_bos_dlg_userMenu.hpp
//	@file Author: Cael817
//	@file Credits:
//	@file Info:

class auxops_base_user_menu
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
		class kp_RscText: auxops_RscText2
		{
			idc = 1000;
			text = "Base User Menu \nLD OFF = Lock Down OFF \nLD ON = LockDown ON \nRe Lock is personal";
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
			text = "LD OFF";
			x = 0.325;
			y = 0.28;
			w = 0.1;
			h = 0.1;
			Action = "call auxops_bos_fnc_release_lockdown";
		};
		class kp_key_2: auxops_RscButton
		{
			idc = 1601;
			text = "LD ON";
			x = 0.45;
			y = 0.28;
			w = 0.1;
			h = 0.1;
			Action = "call auxops_bos_fnc_lockdown";
		};
/* 		class kp_key_3: auxops_RscButton //comment this if you dont want a user to have the ability to change PIN
		{
			idc = 1602;
			text = "Set PIN";
			x = 0.575;
			y = 0.28;
			w = 0.1;
			h = 0.1;
			Action = "call auxops_fnc_change_pin; closeDialog 0";		
		}; */
		class kp_key_4: auxops_RscButton
		{
			idc = 1603;
			text = "Memorize PIN";
			x = 0.325;
			y = 0.4;
			w = 0.35;
			h = 0.05;
			Action = "call auxops_fnc_memorize_pin";
		};
		class kp_key_5: auxops_RscButton
		{
			idc = 1604;
			text = "Re Lock YOUR Base Objects";
			x = 0.325;
			y = 0.47;
			w = 0.35;
			h = 0.05;
			Action = "call auxops_bos_fnc_re_lock";
		};

		class kp_key_6: auxops_RscButton
		{
			idc = 1605;
			text = "Spare Button 1";
			x = 0.325;
			y = 0.54;
			w = 0.35;
			h = 0.05;
		};
		class kp_key_7: auxops_RscButton
		{
			idc = 1606;
			text = "Spare Button 2";
			x = 0.325;
			y = 0.61;
			w = 0.35;
			h = 0.05;
		};
		class kp_key_8: auxops_RscButton
		{
			idc = 1607;
			text = "Spare Button 3";
			x = 0.325;
			y = 0.68;
			w = 0.35;
			h = 0.05;
		};
	};
};	
