#include "script_component.hpp"

if (!isServer || GVAR(emergencyExtinguish)) exitWith {};

GVAR(emergencyExtinguish) = true;

[
    {
        count GVAR(burningObjects) == 0
    }, {
        GVAR(emergencyExtinguish) = false;
    },
] call CBA_fnc_waitUntilAndExecute;
