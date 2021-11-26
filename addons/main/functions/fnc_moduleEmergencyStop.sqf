#include "script_component.hpp"

params ["_logic", "", "_activated"];

if (!isServer || GVAR(emergencyExtinguish)) exitWith {deleteVehicle _logic};
GVAR(emergencyExtinguish) = true;
GVAR(burningObjects) = [];
publicVariable QGVAR(burningObjects);
[
    {
        params ["_logic"];
        deleteVehicle _logic;
        GVAR(emergencyExtinguish) = false;
    },
    nil,
    GVAR(spreadSleep)*1.1
] call CBA_fnc_waitAndExecute;
