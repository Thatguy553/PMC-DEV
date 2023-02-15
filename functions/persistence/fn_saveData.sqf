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
missionProfileNamespace setVariable [Format["PMCSaveData-%1", worldName], PMC_SaveData];
saveMissionProfileNamespace;