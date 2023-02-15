/*
addAction to use this script:
this addAction ["Spawn Base Container", { params["_target", "_caller"]; [this, _caller] call PMC_fnc_spawnBaseBox; }, nil, 1.5, true, true, "", "getPlayerUID _caller isEqualTo PMC_Approved"];
*/

params ["_obj", "_caller"];

if !((getPlayerUID _caller) in PMC_Approved) exitWith {
	hint "You must be approved by an administrator to spawn a new base!";
};

if (_caller getVariable ['PMC_FACTION', 'null'] isEqualTo 'null') then {
	hint "You must create a faction first!";
};

hint "Spawning Base Box...";
private ["_objCords", "_container"];
// _objCords = getPosATL _obj;
// _objCords = [[(_objCords select 0) + 10, (_objCords select 1) + 10, _objCords select 2], 1, 150, 3, 0, 20, 0] call BIS_fnc_findSafePos;
_container = Base_Container createVehicle (getMarkerPos "base_container_spawn");
_container addAction [
	"Deploy Base",
	format["
	{
		params ['_target', '_caller'];
		[_target, %1] call PMC_fnc_createBase;
	}", _caller getVariable ['PMC_FACTION', 'null']],
	nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	""			// shortcut
]