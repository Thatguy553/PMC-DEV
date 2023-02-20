_saveData = missionProfileNamespace getVariable [Format["PMCSaveData-%1", worldName], [[], []]];
if (isNil "_saveData" || (count _saveData) == 0) then {
	[]
};
_saveData