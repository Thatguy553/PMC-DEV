[] call compileFinal preprocessFileLineNumbers "scripts\initVariables.sqf";
PMC_SaveData = [] call PMC_fnc_getSaveData;
diag_log format["[PMC] Init Save Data: %1", PMC_SaveData];
if (isNil "PMC_SaveData" || (count PMC_SaveData) == 0) then {
    PMC_Factions = [];
    PMC_Bases = [];
} else {
    PMC_Factions = PMC_SaveData select 0;
    PMC_Bases = PMC_SaveData select 1;
};

// Faction Assignment
_assign_faction = {
    params ["_player", "_factionsDefined"];
    if !(_factionsDefined) then { diag_log "[PMC] No Factions defined when assigning initial faction."; };
    private ["_playerUID", "_factionIndex", "_faction", "_factionID"];
    _playerUID = getPlayerUID _player;
    if !(_factionsDefined) then {
        _factionIndex = -1;
    } else {
        _factionIndex = PMC_Factions findIf {
            if (_playerUID in (_x select 3)) then {
                true
            };
            if (_playerUID in (_x select 4)) then {
                true
            };
        };
    };

    if (_factionIndex == -1) then {
        _player setVariable ["PMC_FACTION", "none"];
    } else {
        _faction = PMC_Factions select _factionIndex;
        _factionID = _faction select 0;
        _player setVariable ["PMC_FACTION", _factionID];
    };
};

if (isNil "PMC_Factions") then {
    [player, false] call _assign_faction;
} else {
    [player, true] call _assign_faction;
};

player addEventHandler ["Respawn", {
    params ["_unit", "_corpse"];
	private ["_factionID"];
    _factionID = _corpse getVariable ["PMC_FACTION", "none"];
    
    if (_factionID isNotEqualTo "none") then {
        _unit setPosATL (getMarkerPos _factionID);
        _unit setVariable ["PMC_FACTION", _factionID];
    } else {
        _unit setPosATL (getMarkerPos "PMC_HOME");
        _unit setVariable ["PMC_FACTION", "none"];
    };
}];

addMissionEventHandler [
    "EntityKilled",
    {
        params ["_unit", "_killer", "_instigator"];
        _unitSide = side (group _unit);
        _killerSide = side (group _killer);

        if (_unitSide == _killerSide) exitWith {
            [format["%1 was killed by %2 %3", name _unit, name _killer, "(friendly fire)"]] remoteExec ["systemChat", -2];
        };
        if !(isPlayer _killer) exitWith {
            [format["%1 was killed by %2 %3", name _unit, name _killer, "(AI)"] ] remoteExec ["systemChat", -2];
        };
        if (!(isPlayer _unit) && (side group _unit) == civilian) exitWith {
            [format["%1 killed %2 %3, watch your fire!", name _killer, name _unit, "(AI)"] ] remoteExec ["systemChat", -2];
        };
        [format["%1 was killed by %2", name _unit, name _killer] ] remoteExec ["systemChat", -2];
    }
];

if ((getPlayerUID player) in PMC_Administrators) then {
    player addAction [
        "Save Game",
        {
            [] call PMC_fnc_saveData;
        }
    ];
};