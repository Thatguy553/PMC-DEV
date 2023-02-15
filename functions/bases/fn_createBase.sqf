params ["_obj", "_faction"];

if (_faction isEqualTo "null") exitWith {
	hint "You must first join a faction!";
};

if !(([] call PMC_fnc_getBases) findif { (_obj distance2D _x) < Base_Distance } == -1) exitWith {
	hint format["Must be greater than %1m from any other PMC's Base location!", Base_Distance];
};

if ((position _obj) isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []) exitWith {
	hint "Must not be in or too close to the water, Otherwise make sure no objects are too close.";
};

private ["_positionToBuild", "_newBase", "_oldBase", "_existingBases", "_factionID", "_factionName"];
_factionID = _faction select 0;
_factionName = _faction select 1;
_existingBases = call PMC_fnc_getBases;
_oldBase = _existingBases select (_existingBases findIf {(_factionID) isEqualTo (_x getVariable ["PMC_HQ_FACTION", "null"])});

if !(isNull _oldBase) then {
	deleteVehicle _oldBase;
	deleteMarker (_factionID);
};

_positionToBuild = getPosATL _obj;

hideObjectGlobal _obj;

_newBase = _positionToBuild createVehicle Base_Object;
_newBase setVariable ["PMC_HQ_FACTION", _factionID];
_newBase setVehicleVarName format["PMC_HQ_%1", _factionID];

createMarker [_factionID, getPosATL _newBase];
(_factionID) setMarkerText (Format["%1 Base", _factionName]);

deleteVehicle _obj;