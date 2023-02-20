// {
// 	// Current result is saved in variable _x
// 	if ((_x select 4) findif { (getPlayerUID player) isEqualTo _x } || (_x select 3) findif { (getPlayerUID player) isEqualTo _x }) then {
// 		player setPosATL (getmarkerpos (_x select 0));
// 		player setVariable ["PMC_FACTION", _x select 0];
// 	} else {
// 		player setPosATL (getmarkerpos "PMC_HOME");
// 		player setVariable ["PMC_FACTION", "null"];
// 	};
// } forEach PMC_Factions;