params ["_factionID", "_memberID"];

PMC_Factions apply { if ((_x select 0) isEqualTo _factionID) exitWith { (_x select 4) append _memberID; }; };