/*
Faction Data Save Format:
[
	[factionID, "Faction Name", "Cash", [RepresetativesSteamID], [memberSteamID], ["Licenses"]]
]
*/
params ["_caller"];
PMC_processAllThreeGUIs = {
	params ["_factionName", "_factionLeaders", "_factionMembers", "_caller"];
	private ["_factionNum"];
	_factionNum = (Format["000%1", count PMC_Factions]);
    _factionID = format["%1%2", _factionName select [0, 1], (_factionNum select [count _factionNum - 4, count _factionNum - 1])];

	PMC_Factions append [[_factionID, _factionName, PMC_Starting_Cash, _factionLeaders splitString ",", _factionMembers splitString ",", ["G1"]]];

	if (PMC_Factions findIf {(_x select 0) isEqualTo _factionID} > -1) exitWith {
		systemChat format["Your faction has succesfully been created! Assigning you to faction %1...", _factionName];
		_caller setVariable ["PMC_FACTION", _factionID, true];
		[] call PMC_fnc_saveData;
	};
	false

};

// GUI prompt to get faction member steam64ID's from _caller
PMC_show_GUI_3 = {
	[
		[false,"1234567890, 1234567890"], 
    	"Member Steam64IDs seperated by commas", 
        [{
			params ["_gui1_results", "_gui2_results", "_caller"];
			if _confirmed then { 
				systemChat format["Initialized creating faction with name: %1",_gui1_results];
				systemChat format["Initialized creating faction with Admin IDs: %1", _gui2_results];
				systemChat format["Initialized creating faction with Member IDs: %1", _text];
				[_gui1_results, _gui2_results, _text, _caller] 
            	call PMC_processAllThreeGUIs;
			} else { 
				systemChat "Faction Creation Cancelled."; 
			};
        }, [_this select 0, _this select 1, _this select 2]],
		"Send", 
		""
    ] call CAU_UserInputMenus_fnc_text;    
};

// GUI prompt to get faction leader steam64ID's from _caller
PMC_show_GUI_2 = {
    [
		[false,"1234567890, 1234567890"], 
		"Admin Steam64ID's seperated by commas", 
        [{
			params ["_gui1_results", "_caller"];
			if _confirmed then {
				systemChat format["Initialized creating faction with name: %1",_gui1_results];
				systemChat format["Initialized creating faction with Admin IDs: %1", _text];
				[_gui1_results, _text, _caller] call PMC_show_GUI_3;
			} else { 
				systemChat "Faction Creation Cancelled."; 
			};
        }, [_this select 0, _this select 1]],
		"Send", 
		""  // reverts to default 
    ] call CAU_UserInputMenus_fnc_text;
};

// GUI prompt to get faction name from _caller
PMC_show_GUI_1 = {
    [
		[false,""], 
		"Faction Name", 
        [{
			params ["_caller"];
			if _confirmed then {
				systemChat format["Initialized creating faction with name: %1",_text];
				[_text, _caller] call PMC_show_GUI_2;
			} else { 
				systemChat "Faction Creation Cancelled."; 
			};
        }, [_this select 0]],
		"Send", 
		""  // reverts to default 
    ] call CAU_UserInputMenus_fnc_text;
};

[_caller] call PMC_show_GUI_1;

// [[[[[[[]]],["T000","The Red Arrows",500000,["76561198201550691"],["76561198201550691"],["G1"]]]],[[]]]]