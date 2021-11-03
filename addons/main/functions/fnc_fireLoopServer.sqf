#include "script_component.hpp"

params ["_tree", "_endTime", "_nearbyObjects"];
if (time > _endTime) exitWith {
    if (typeOf _tree isEqualTo "") then {
        _tree hideObjectGlobal true;
    } else {
        _tree setDamage ((random 0.45) + 0.55);
    };
};

_nearbyObjects = _nearbyObjects select {_x call FUNC(canBurn)};
if (count _nearbyObjects > 0 && {count GVAR(burningObjects) < GVAR(maxBurningObjects)}) then {
    private _spreadChance = 1 / count _nearbyObjects;
    private _rainCoef = (1.1-rain) max 1;
    private _burn = _nearbyObjects select {
        private _distanceCoef = linearConversion [
            0, 
            GVAR(spreadDistance), 
            _x distance2D _tree,
            1,
            0
        ];
        random 100 < _rainCoef * _distanceCoef * 100
    };
    {
        [_x] remoteExecCall [QFUNC(fire)];
    } forEach _burn;
};

private _sleep = random GVAR(spreadSleep); // Avg is actually spreadSleep/2, however 

for "_i" from 0 to _sleep step 1 do {
    [
        {
            params ["_tree"];
            private _nearbyUnits = _tree nearEntities ["Man", 15];
            {
                [_x] remoteExecCall [QFUNC(fireDamage), _x];
            } forEach _nearbyUnits;
        },
        _tree,
        _i
    ] call CBA_fnc_waitAndExecute;
};

[
    {_this call FUNC(fireLoopServer)},
    [_tree, _endTime, _nearbyObjects], 
    _sleep
] call CBA_fnc_waitAndExecute;