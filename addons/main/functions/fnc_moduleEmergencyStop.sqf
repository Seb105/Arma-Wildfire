#include "script_component.hpp"

params ["_logic", "", "_activated"];

GVAR(emergencyExtinguish) = true;
if !(isServer) exitWith {};
[] spawn {
    _todo = +GVAR(burningObjects);
    {

    } forEach _todo;
}; // Doing all this in 1 frame is a bad idea
[
    {
        count GVAR(burningObjects) == 0
    }, {
        deleteVehicle _this;
        GVAR(emergencyExtinguish) = false;
    },
    _logic
] call CBA_fnc_waitUntilAndExecute;