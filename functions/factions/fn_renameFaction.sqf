params ["_factionID", "_newName"];

_factionIndex = PMC_Factions findIf { _x select 0 isEqualTo _factionID };

_originalName = (PMC_Factions select _factionIndex) select 1;
(PMC_Factions select _factionIndex) set [1, _newName];

diag_log format ["[PMC] Faction Name Change: %1 to %2", _originalName, _newName];