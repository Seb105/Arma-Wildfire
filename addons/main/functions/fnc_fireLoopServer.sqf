#include "script_component.hpp"

params ["_tree", "_endTime", "_nearbyObjects"];
if (time > _endTime) exitWith {
    if (typeOf _tree isEqualTo "") then {
        _tree hideObjectGlobal true;
    } else {
        _tree setDamage ((random 0.8) + 0.8);
    };
};

_nearbyObjects = _nearbyObjects select {_x call FUNC(canBurn)};
if (count _nearbyObjects > 0 && {count GVAR(burningObjects) < GVAR(maxBurningObjects)}) then {
    private _spreadChance = 1 / count _nearbyObjects;
    private _burn = _nearbyObjects select {random 100 < (25 - rain * 20) * (1 - ((_x distance2D _tree) / GVAR(spreadDist)))};
    {
        [_x] remoteExecCall [QGVAR(fire)];
    } forEach _burn;
};

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
    random GVAR(spreadSleep)
] call CBA_fnc_waitAndExecute;