[] call PMC_fnc_setupBases;

// Initiate Save loop to run every 5 minutes
_save_loop = {
	[{
		diag_log format["[PMC] Saving: %1", str PMC_SaveData];
		[] call PMC_fnc_saveData;
		[] call _save_loop;
		["Saving Server..."] remoteExec ["systemChat", 2];
	}, [], PMC_SaveInterval] call CBA_fnc_waitAndExecute;
};
[{
	diag_log format["[PMC] Saving: %1", str PMC_SaveData];
	[] call PMC_fnc_saveData;
	[] call _save_loop;
	["Saving Server..."] remoteExec ["systemChat", 2];
}, [], PMC_SaveInterval] call CBA_fnc_waitAndExecute;


// If any factions exist create their markers.
if ((count PMC_Factions) > 0) then {
	{
		// Current result is saved in variable _x
		_factionID = _x select 0;
		_base = PMC_Bases findif {(_x select 0) isEqualTo _factionID};
		createMarker [_factionID, getPosATL _base];
		_factionID setMarkerText (Format["%1 Base", _factionID]);
	} forEach PMC_Factions;
};