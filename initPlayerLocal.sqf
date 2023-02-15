// Assign Faction Members
{
	// Current result is saved in variable _x
	if ((_x select 4) findif { (getPlayerUID player) == _x } == -1) then {
		_this setPosATL (getmarkerpos (_x select 0));
        _this setVariable ["PMC_FACTION", _x select 0];
	} else {
		_this setPosATL (getmarkerpos "PMC_HOME");
        _this setVariable ["PMC_FACTION", 'null'];
	};
} forEach PMC_Factions;

//CBA Settings Stuff
[] spawn {
    if (!hasInterface) exitWith {};

    if (
        (isNil "ace_advanced_fatigue_enabled") ||
        (!isNil "ace_advanced_fatigue_enabled" && {!ace_advanced_fatigue_enabled})
    ) exitWith {
        player setCustomAimCoef 0.2;
    };

    if (!ace_advanced_fatigue_enabled) exitWith {};

    waitUntil {sleep 0.1; !isNil {(missionNamespace getVariable ["ACE_setCustomAimCoef", nil])}};

    private _aimHash = (missionNamespace getVariable ["ACE_setCustomAimCoef", nil]);

    waituntil {sleep 0.1; ("ace_medical" in _aimHash)};

    [missionNamespace, "ACE_setCustomAimCoef", "ace_medical", {
        private _pain = (ACE_player getVariable ["ace_medical_pain", 0]);
        private _painSupp = (ACE_player getVariable ["ace_medical_painSuppress", 0]);
        private _fatigue = ACE_Player getVariable ["ace_advanced_fatigue_aimFatigue", 0];

        private _stanceCoef = (
            switch (stance ACE_Player) do {
                case ("CROUCH"): {
                    (1.0 + _fatigue ^ 2 * 0.1)
                };
                case ("PRONE"): {
                    (1.0 + _fatigue ^ 2 * 2.0)
                };
                default {
                    (1.5 + _fatigue ^ 2 * 3.0)
                };
            }
        );

        (
            (
                (linearConversion [0, 1, (0 max (_pain - _painSupp) min 1), 1, 5, true]) +
                (ACE_player getVariable ["ace_medical_engine_aimFracture", 0])
            ) * _stanceCoef
        ) * ace_advanced_fatigue_swayFactor
    }] call ace_common_fnc_arithmeticSetSource;
};