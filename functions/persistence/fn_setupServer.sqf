/*
Save Data Format:
[
	[FactionData],
	[BaseData]
]

Faction Data Save Format:
[
	[factionID, "Faction Name", "Cash", [RepresetativesSteamID], [memberSteamID], ["Licenses"]],
	[factionID, "Faction Name2", "Cash", [RepresetativesSteamID], [memberSteamID], ["Licenses"]]
]

Base Data Save Format:
[
	[factionID, [HQPosATL, vectorDir, vectorUp], [[ObjectClass, 3D ATL Cords, vectorDir, vectorUp]] ],
	[factionID2, [HQPosATL2, vectorDir, vectorUp], [[ObjectClass, 3D ATL Cords, vectorDir, vectorUp]] ]
]
*/


_saveData = call PMC_fnc_loadSaveData;
if (_saveData isEqualTo []) exitWith {
	diag_log "[PMC] No save data found.";
};

PMC_Factions = _saveData select 0;
if (PMC_Factions isEqualTo []) exitWith {
	diag_log "[PMC] No Factions found.";
};

PMC_Bases = _saveData select 1;
if (PMC_Bases isEqualTo []) exitWith {
	diag_log "[PMC] No Bases found.";
};

private ["_hq", "_hqObj"];

{
	// Current result is saved in variable _x
	_hq = Base_Object createVehicle ((_x select 1) select 0);
	_hq setVectorDir ((_x select 1) select 1);
	_hq setVectorUp ((_x select 1) select 2);

	{
		// Current result is saved in variable _x
		_hqObj = (_x select 0) createVehicle (_x select 1);
		_hqObj setVectorDir (_x select 2);
		_hqObj setVectorUp (_x select 3);
	} forEach (_x select 2);
} forEach PMC_Bases;