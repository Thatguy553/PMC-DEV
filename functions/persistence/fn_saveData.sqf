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
HQBuildings will have var name PMC_HQ_factionID
[
	[factionID, [HQPosATL, 3D ATL Cords, vectorDir, vectorUp], [ [ObjectClass, 3D ATL Cords], [ObjectClass, 3D ATL Cords, vectorDir, vectorUp], [VehicleClass, 3D ATL Cords, vectorDir, vectorUp] ]],
	[factionID2, [HQPosATL2, 3D ATL Cords, vectorDir, vectorUp], [ [ObjectClass, 3D ATL Cords], [ObjectClass, 3D ATL Cords, vectorDir, vectorUp], [VehicleClass, 3D ATL Cords, vectorDir, vectorUp] ]]
]
*/
private ["_factions", "_bases"];
_factions = call PMC_fnc_getFactions;
_bases = call PMC_fnc_getBases;

diag_log format["[PMC] Save Faction Data: %1", _factions];
diag_log format["[PMC] Save Bases Data: %1", _bases];

PMC_SaveData = [[_factions], [_bases]];
diag_log format["[PMC] Save Data: %1", PMC_SaveData];

missionProfileNamespace setVariable [Format["PMCSaveData-%1", worldName], PMC_SaveData];
saveMissionProfileNamespace;

// PMC_SaveData = [[], []];

// [[],[["T000","The Red Arrows",500000,["76561198201550691"],["76561198201550691"],["G1"]]]]