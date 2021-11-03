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
    private _rainCoef = (1.1-rain) min 1;
    private _spreadDistWind = (1 + windStr) * GVAR(spreadDistance);
    private _area = [_tree, _spreadDistWind] call FUNC(getWindArea);
    private _burn = (_nearbyObjects inAreaArray _area) select {[_tree, _x, _rainCoef, _spreadDistWind] call FUNC(shouldStartFire)};
    {
        [_x] remoteExecCall [QFUNC(fire)];
    } forEach _burn;
};

private _sleep = random GVAR(spreadSleep); // Avg is actually spreadSleep/2

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