/*
Should get all bases associated with a faction and return an array of the the base HQ objects;

Return:
[object, object, object, etc]
*/

private ["_factions", "_factionID", "_bases", "_baseObj"];
_bases = [];
_factions = call PMC_fnc_getFactions;

if (_factions isEqualTo []) exitWith {
	[];
};

{
	// Current result is saved in variable _x
	_factionId = _x select 0;
	_baseObj = missionNamespace getVariable (format["PMC_HQ_", _factionID]);
	if !(isNil "_baseObj") then {
		_bases append _baseObj;
	};
} forEach _factions;

_bases