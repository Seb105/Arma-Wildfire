#include "script_component.hpp"

params ["_logic", "", "_activated"];

if !(isServer && _activated) exitWith {};
0 call FUNC(emergencyStop);
[
    {
        params ["_logic"];
        deleteVehicle _logic;
    },
    _logic,
    10
] call CBA_fnc_waitAndExecute;
