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

if (PMC_Bases isEqualTo []) exitWith {
	diag_log "[PMC] No Bases found.";
};

private ["_hq", "_hqObj"];

{
	// Current result is saved in variable _x
	_hq = PMC_Base_Object createVehicle ((_x select 1) select 0);
	_hq setVectorDir ((_x select 1) select 1);
	_hq setVectorUp ((_x select 1) select 2);

	{
		// Current result is saved in variable _x
		_hqObj = (_x select 0) createVehicle (_x select 1);
		_hqObj setVectorDir (_x select 2);
		_hqObj setVectorUp (_x select 3);
	} forEach (_x select 2);
} forEach PMC_Bases;