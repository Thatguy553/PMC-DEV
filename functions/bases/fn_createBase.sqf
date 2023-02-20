params ["_obj", "_factionID"];
if (isNil "_factionID") exitWith {
	systemChat "You must first join a faction!";
};

if !(([] call PMC_fnc_getBases) findif { (_obj distance2D _x) < PMC_Base_Distance } == -1) exitWith {
	systemChat format["Must be greater than %1m from any other PMC's Base location!", PMC_Base_Distance];
};

if ((position _obj) isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []) exitWith {
	systemChat "Must not be in or too close to the water, Otherwise make sure no objects are too close.";
};

private ["_positionToBuild", "_newBase", "_oldBase", "_existingBases", "_factionName"];
_faction = PMC_Factions select (PMC_Factions findIf {(_x select 0) isEqualTo _factionID});
_factionName = _faction select 1;
_existingBases = call PMC_fnc_getBases;
if (_existingBases isNotEqualTo []) then {
	_oldBase = _existingBases select (_existingBases findIf {(_factionID) isEqualTo (_x getVariable ["PMC_HQ_FACTION", "null"])});
};

if !(isNil "_oldBase") then {
	deleteVehicle _oldBase;
	deleteMarker (_factionID);
};

_positionToBuild = getPosATL _obj;

hideObjectGlobal _obj;

_newBase = PMC_Base_Object createVehicle _positionToBuild;
_newBase setVariable ["PMC_HQ_FACTION", _factionID];
_newBase setVehicleVarName format["PMC_HQ_%1", _factionID];
_newBase setVectorDir (vectorDir _obj);
// _newBase setVectorUp (vectorUp _obj);

_baseMarker = createMarker [_factionID, position _newBase];
(_factionID) setMarkerType "b_hq";
(_factionID) setMarkerText (Format["%1 Base", _factionName]);

deleteVehicle _obj;