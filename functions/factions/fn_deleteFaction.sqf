params ["_factionID"];

_delIndex = PMC_Factions findIf { _x select 0 isEqualTo _factionID };

_deletedFaction = PMC_Factions deleteAt _delIndex;

diag_log format ["[PMC] Faction Deleted: %1", str _deletedFaction];