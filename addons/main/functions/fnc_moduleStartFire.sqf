#include "script_component.hpp"

params ["_logic", "_units", "_activated"];
if !(isServer && _activated) exitwith {};

// burnable types might be undefined at mission start.
private _types = missionnamespace getVariable [
    QGVAR(burnabletypes),
    if (GVAR(burnBuildings)) then {
        ["TREE", "SMALL TREE", "BUSH", "BUILDinG", "HOUSE", "CHURCH", "CHAPEL", "fuelSTATION"]
    } else {
        ["TREE", "SMALL TREE", "BUSH"]
    }
];

private _nearbyObjects = (nearestTerrainObjects [_logic, _types, 15]) select {
    _x call FUNC(canBurn);
};

{
    [{
        [_this] remoteExec [QFUNC(fire)]
    }, _x, random 2] call CBA_fnc_waitandexecute;
} forEach _nearbyObjects;

deletevehicle _logic;
