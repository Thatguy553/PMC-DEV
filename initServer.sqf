[] call compileFinal preprocessFileLineNumbers "scripts\initVariables.sqf";
[] call PMC_fnc_setupServer;


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