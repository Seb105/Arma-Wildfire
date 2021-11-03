#include "script_component.hpp"

params ["_tree", "_endTime", "_nearbyObjects"];
if (time > _endTime) exitWith {
    if (typeOf _tree isEqualTo "") then {
        _tree hideObjectGlobal true;
    } else {
        _tree setDamage ((random 0.8) + 0.8);
    };
};

_nearbyObjects = _nearbyObjects select {!(_x in seb_burningObjects || _x in seb_burnedObjects)};
if (count _nearbyObjects > 0 && {count seb_burningObjects < seb_maxBurningObjects}) then {
    private _spreadChance = 1 / count _nearbyObjects;
    private _burn = _nearbyObjects select {random 100 < (25 - rain * 20) * (1 - ((_x distance2D _tree) / seb_spreadDist))};
    {
        [_x] remoteExecCall ["seb_fnc_fire"];
    } forEach _burn;
};

private _sleep = seb_fireSleep/2 + random seb_fireSleep;

for "_i" from 0 to _sleep step 1 do {
    [
        {
            params ["_tree"];
            private _nearbyUnits = _tree nearEntities ["Man", 15];
            {
                [_x] remoteExecCall ["seb_fnc_fireDamage", _x];
            } forEach _nearbyUnits;
        },
        _tree,
        _i
    ] call CBA_fnc_waitAndExecute;
};

[
    {_this call seb_fnc_fireLoop},
    [_tree, _endTime, _nearbyObjects], 
    _sleep
] call CBA_fnc_waitAndExecute;