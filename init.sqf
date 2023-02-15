player addEventHandler ["Respawn", {

	{
		// Current result is saved in variable _x
		
		if ((_x select 4) findif { (getPlayerUID player) == _x } == -1) then {
			_this setPosATL (getmarkerpos (_x select 0));
			_this setVariable ["PMC_FACTION", _x select 0];
		} else {
			_this setPosATL (getmarkerpos "PMC_HOME");
			_this setVariable ["PMC_FACTION", "null"];
		};
	} forEach PMC_Factions;
}
];