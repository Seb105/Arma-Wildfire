#include "script_component.hpp"

params ["_logic", "", "_activated"];

if !(isServer && _activated) exitwith {};
0 call FUNC(emergencystop);
[
    {
        params ["_logic"];
        deletevehicle _logic;
    },
    _logic,
    10
] call CBA_fnc_waitandexecute;
