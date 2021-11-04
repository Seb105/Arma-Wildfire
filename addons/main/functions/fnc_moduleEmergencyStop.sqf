#include "script_component.hpp"

params ["_logic", "", "_activated"];

if (!isServer || GVAR(emergencyExtinguish)) exitWith {};
GVAR(emergencyExtinguish) = true;

[
    {
        count GVAR(burningObjects) == 0
    }, {
        params ["_logic"];
        deleteVehicle _logic;
        GVAR(emergencyExtinguish) = false;
    },
    _logic
] call CBA_fnc_waitUntilAndExecute;
