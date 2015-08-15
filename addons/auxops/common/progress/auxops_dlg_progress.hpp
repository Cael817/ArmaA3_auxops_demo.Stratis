// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version:
//	@file Name:
//	@file Author: Cael817
//	@file Credits: AirFell based on AF_KeyPad http://www.armaholic.com/page.php?id=26498
//	@file Info:

class auxops_progress : auxops_RscBackground {
	idd = 81701;//idd = 10101;
	movingEnabled = false;
	controls[] = {auxops_ProgressBar, auxops_Button, auxops_Text};
	controlsBackground[] = {auxops_Background};

	class auxops_ProgressBar : auxops_RscProgressBar {
		idc = 81701;//idc = 10101;
		x = 0.2;
		y = -0.35;
		w = 0.5;
		h = 0.05;
	};

	class auxops_Button : auxops_RscButton {
		idc = -1;
		text = "Cancel";
		x = 0.71;
		y = -0.35;
		w = 0.09;
		h = 0.05;
		action = "auxops_actions_mutex = false; closeDialog 81701";
	};

	class auxops_Text : auxops_RscStructuredText {
		idc = 81702;//idc = 10102;
		x = 0.2;
		y = -0.35;
		w = 0.5;
		h = 0.05;
		class Attributes {
			align = "center";
			valign = "middle";
		};
	};

	class auxops_Background : auxops_RscBackground {
		idc = -1;
		x = 0.19;
		y = -0.36;
		w = 0.62;
		h = 0.07;
	};
};

