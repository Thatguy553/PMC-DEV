/*
addAction to use this script:
this addAction ["Spawn Base Container", { params["_target", "_caller"]; [this, _caller] call PMC_fnc_spawnBaseBox; }, nil, 1.5, true, true, "", "getPlayerUID _caller isEqualTo PMC_Approved"];
*/

params ["_obj", "_caller"];

if !((getPlayerUID _caller) in PMC_Approved) exitWith {
	hint "You must be approved by an administrator to spawn a new base!";
};

if ((_caller getVariable ['PMC_FACTION', "none"]) isEqualTo "none") then {
	hint "You must create a faction first!";
};

hint "Spawning Base Container...";
private ["_objCords", "_container"];
_container = PMC_Base_Container createVehicle (getMarkerPos "PMC_Base_Container_spawn");
_container addAction [
	"Deploy Base",
	{
		params ['_target', '_caller'];
		[_target, _caller getVariable ['PMC_FACTION', "none"]] call PMC_fnc_createBase;
	}
];