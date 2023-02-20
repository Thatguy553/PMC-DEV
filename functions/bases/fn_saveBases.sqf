/*
Base Data Save Format:
HQBuildings will have var name PMC_HQ_factionID
[
	[factionID, [HQPosATL, 3D ATL Cords, vectorDir, vectorUp], [ [ObjectClass, 3D ATL Cords, vectorDir, vectorUp], [ObjectClass, 3D ATL Cords, vectorDir, vectorUp]]]
]
*/
private ["_factions", "_baseObjects", "_basesArray"];

{
	_nObjs = nearestObjects [_x, [] call PMC_fnc_saveableObjects, PMC_Base_Radius, true];
	_nObjsFormated = [];
	{
		_nObjsFormated pushBack [[typeOf _x, getPosATL _x, vectorDir _x, vectorUp _x]];
	} forEach _nObjs;
	_basesArray pushBack [[_x getVariable ["PMC_HQ_FACTION", "null"], [getPosATL _x, vectorDir _x, vectorUp _x], _nObjsFormated]];
} forEach (call PMC_fnc_getBases);

_basesArray