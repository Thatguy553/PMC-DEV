/*
Faction Data Save Format:
[
	[factionID, "Faction Name", "Cash", [RepresetativesSteamID], [memberSteamID], ["Licenses"]]
]
*/

params ["_factionName", "_factionLeaders", "_factionCash"];
private ["_factionID"];

_factionID = ([_factionName, 0, 1] call BIS_fnc_trimString) + [(Format["000%1", count PMC_Factions]), 0, 2] call BIS_fnc_trimString;

PMC_Factions append [[_factionID, _factionName, Starting_Cash, _factionLeaders, [], ["G1"]]];